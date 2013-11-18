# initial compile tasks taken from https://gist.github.com/jeffreyiacono/1772989#file-rakefile
namespace :assets do
  require 'sprockets'

  desc 'compile assets'
  task :compile => [:clean, :compile_js, :compile_css] do
  end

  desc 'clean assets'
  task :clean => [:clean_js, :clean_css] do
  end

  desc 'compile javascript assets'
  task :compile_js => :environment do
    sprockets = Sprockets::Environment.new
    sprockets.append_path Assets::Javascripts::LOAD_PATH
    asset     = sprockets['application.js'] || sprockets['application.coffee']
    outpath   = Assets::Javascripts::COMPILE_PATH
    outfile   = Pathname.new(outpath).join('application.js') # may want to use the digest in the future?

    FileUtils.mkdir_p outfile.dirname

    asset.write_to(outfile)
    puts "successfully compiled js assets to #{outfile}"
  end

  desc 'compile css assets'
  task :compile_css => :environment do
    sprockets = Sprockets::Environment.new
    sprockets.append_path Assets::Stylesheets::LOAD_PATH
    asset     = sprockets['application.css'] || sprockets['application.scss']
    outpath   = Assets::Stylesheets::COMPILE_PATH
    outfile   = Pathname.new(outpath).join('application.css') # may want to use the digest in the future?

    FileUtils.mkdir_p outfile.dirname

    asset.write_to(outfile)
    puts "successfully compiled css assets to #{outfile}"
  end

  desc 'clean javascript assets'
  task :clean_js => :environment do
    file = Pathname.new(Assets::Javascripts::COMPILE_PATH).join('application.js')
    File.delete(file) if File.exists?(file)
    puts "successfully cleaned js assets"
  end

  desc 'clean css assets'
  task :clean_css => :environment do
    file = Pathname.new(Assets::Stylesheets::COMPILE_PATH).join('application.css')
    File.delete(file) if File.exists?(file)
    puts "successfully cleaned css assets"
  end

end