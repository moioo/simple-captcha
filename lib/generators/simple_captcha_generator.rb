require 'rails/generators'

class SimpleCaptchaGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  desc "Copy  migration to your application."
  class_option :orm, :type => :string, :aliases => "-o", :default => "active_record", :desc => "ORM options: active_record"

  def copy_files
    orm = options[:orm].to_s
    orm = "active_record" unless %w{active_record mongoid}.include?(orm)
    if orm == "active_record"
      migration_template "migration.rb", "db/migrate/create_simple_captcha_data.rb"
    end
    template "partial.erb", File.join('app/views', 'simple_captcha', "_simple_captcha.erb")
  end
  def self.next_migration_number(dirname)
   if ActiveRecord::Base.timestamped_migrations
     Time.now.utc.strftime("%Y%m%d%H%M%S")
   else
     "%.3d" % (current_migration_number(dirname) + 1)
   end
  end
end
