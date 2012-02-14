namespace :spree_reviews do
  desc "Copies all migrations and assets (NOTE: This will be obsolete with Rails 3.1)"
  task :install do
    Rake::Task['spree_reviews:install:migrations'].invoke
    Rake::Task['spree_reviews:install:assets'].invoke
  end

  namespace :install do
    desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
    task :migrations do
      source = File.join(File.dirname(__FILE__), '..', '..', 'db')
      destination = File.join(Rails.root, 'db')
      puts "INFO: Mirroring assets from #{source} to #{destination}"
      Spree::Core::FileUtilz.mirror_files(source, destination)
    end

    desc "Copies all assets (NOTE: This will be obsolete with Rails 3.1)"
    task :assets do
      source = File.join(File.dirname(__FILE__), '..', '..', 'public')
      destination = File.join(Rails.root, 'public')
      puts "INFO: Mirroring assets from #{source} to #{destination}"
      Spree::Core::FileUtilz.mirror_files(source, destination)
    end
  end
end
