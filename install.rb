require 'fileutils'

FileUtils.cp File.dirname(__FILE__) + '/../../../public/javascripts/prototype.js', File.dirname(__FILE__) + '/../../../public/javascripts/prototype.bak'
FileUtils.cp File.dirname(__FILE__) + '/assets/javascripts/paginator.js', File.dirname(__FILE__) + '/../../../public/javascripts/paginator.js'
FileUtils.cp File.dirname(__FILE__) + '/assets/javascripts/prototype.js', File.dirname(__FILE__) + '/../../../public/javascripts/prototype.js'