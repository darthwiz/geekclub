ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'development'

namespace :db do
  namespace :fixtures do
    desc "Load a single fixture by setting FIXTURE=name of fixture you wish to laod."
    task :load_single => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[RAILS_ENV])
      Fixtures.create_fixtures("test/fixtures", [ENV['FIXTURE']])
      puts "Fixture #{ENV['FIXTURE']} loaded in to #{RAILS_ENV} environment."
    end
  end
end
