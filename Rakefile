require 'rake'
require 'rake/rdoctask'
require 'fileutils'


desc 'Generate documentation for the acts_as_pageless plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'EndlessPageless'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Removes/reverts the javascripts for the plugin.'
task :remove_scripts do
  FileUtils.rm %{paginator.js}.collect { |f| "../../../public/javascripts/" + f  }
  if FileTest.exist? "../../../public/javascripts/prototype.bak"
    FileUtils.cp File.dirname(__FILE__) + '/../../../public/javascripts/prototype.bak', File.dirname(__FILE__) + '/../../../public/javascripts/prototype.js'
    FileUtils.rm %{prototype.bak}.collect { |f| "../../../public/javascripts/" + f  }
  end
end