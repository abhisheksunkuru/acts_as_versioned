require 'helper'

class Thing < ActiveRecord::Base
  attr_accessor :version
  acts_as_versioned
end

class MigrationTest < AAVTestCase
  
  let(:mig_dir) { "#{TEST_ROOT}/migrations" }
  
  before do
    ActiveRecord::Migration.verbose = false
  end
 
  def test_versioned_migration
    assert_raises(ActiveRecord::StatementInvalid) { Thing.create :title => 'blah blah' }
    # # take 'er up
    ActiveRecord::Migrator.up(mig_dir)
    t = Thing.create :title => 'blah blah', :price => 123.45, :type => 'Thing'
    assert_equal 1, t.versions.size
    # check that the price column has remembered its value correctly
    assert_equal t.price,  t.versions.first.price
    assert_equal t.title,  t.versions.first.title
    assert_equal t[:type], t.versions.first[:type]
    # make sure that the precision of the price column has been preserved
    assert_equal 7, Thing::Version.columns.find{|c| c.name == "price"}.precision
    assert_equal 2, Thing::Version.columns.find{|c| c.name == "price"}.scale
    # # now lets take 'er back down
    ActiveRecord::Migrator.down(mig_dir)
    assert_raises(ActiveRecord::StatementInvalid) { Thing.create :title => 'blah blah' }
  end
  
end
