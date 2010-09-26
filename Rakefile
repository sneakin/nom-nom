require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "nom_nom"
    gem.summary = %Q{COOKIE!!}
    gem.description = %Q{I consume web service. Nom nom nom.}
    gem.email = "sneakin+nomnom@semanticgap.com"
    gem.homepage = "http://github.com/sneakin/nom-nom"
    gem.authors = ["Nolan Eakins"]
    gem.add_development_dependency "rspec"
    gem.add_dependency('nokogiri', '= 1.4.3.1')
    gem.add_dependency('httparty', '= 0.6.1')
    gem.add_dependency('activesupport', '= 3.0.0')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "nom_nom #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'yard'
require 'yard/rake/yardoc_task'

desc 'Generate Yardoc documentation'
YARD::Rake::YardocTask.new do |yardoc|
  yardoc.name = 'doc'
  yardoc.options = ['--verbose']
  yardoc.files = [ 'lib/**/*.rb', 'examples/**/*.rb', 'LICENSE', 'README.md' ]
end
