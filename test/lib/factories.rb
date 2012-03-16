require 'factory_girl'

module Seed
  class Page < ActiveRecord::Base ; self.table_name = 'pages' ; end
  class PageVersion < ActiveRecord::Base ; self.table_name = 'page_versions' ; end
  class LockedPage < ActiveRecord::Base ; self.table_name = 'locked_pages' ; end
  class LockedPageRevision < ActiveRecord::Base ; self.table_name = 'locked_pages_revisions' ; end
  class Author < ActiveRecord::Base ; self.table_name = 'authors' ; end
  class Widget < ActiveRecord::Base ; self.table_name = 'widgets' ; end
  class WidgetVersion < ActiveRecord::Base ; self.table_name = 'widget_versions' ; end
  class Landmark < ActiveRecord::Base ; self.table_name = 'landmarks' ; end
  class LandmarkVersion < ActiveRecord::Base ; self.table_name = 'landmark_versions' ; end
end

FactoryGirl.define do
  
  factory :page do
    title  { Forgery(:lorem_ipsum).words(4) }
    body   { Forgery(:lorem_ipsum).words(30) }
  end
  
  factory :locked_page do
    title  { Forgery(:lorem_ipsum).words(4) }
  end
  
  # Seeds
  
  factory :seed_author,           :class => Seed::Author
  factory :seed_page,             :class => Seed::Page
  factory :seed_page_version,     :class => Seed::PageVersion
  factory :seed_locked_page,      :class => Seed::LockedPage
  factory :seed_locked_page_rev,  :class => Seed::LockedPageRevision
  factory :seed_landmark,         :class => Seed::Landmark
  factory :seed_landmark_version, :class => Seed::LandmarkVersion
  
end
