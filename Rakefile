begin
  require 'rake/gempackagetask'
rescue LoadError
end
require 'rake/clean'
require 'rbconfig'
include Config

PKG_NAME = 'dslkit'
PKG_VERSION = File.read('VERSION').chomp
PKG_FILES = FileList['**/*'].exclude(/(CVS|\.svn|pkg|coverage|doc)/)
CLEAN.include 'coverage', 'doc'

desc "Installing library"
task :install  do
  ruby 'install.rb'
end

desc "Creating documentation"
task :doc do
  ruby 'make_doc.rb'
end

desc "Testing library"
task :test  do
  ruby '-Ilib tests/runner.rb'
end

desc "Testing library with coverage"
task :coverage  do
  system 'rcov -Ilib tests/test_rude.rb'
end

if defined? Gem
  spec = Gem::Specification.new do |s|
    s.name = PKG_NAME
    s.version = PKG_VERSION
    s.summary = 'Kit for building DSLs in Ruby'
    s.description = 'This library contains recurring patterns, that are useful in the creation of internal Domain Specific Languages (DSL) in Ruby.'

    s.add_dependency('term-ansicolor', '~>1.0')

    s.files = PKG_FILES

    s.require_path = 'lib'

    s.has_rdoc = true
    s.rdoc_options << '--main' << 'doc-main.txt'
    s.extra_rdoc_files << 'doc-main.txt'
    s.test_files << 'tests/runner.rb'

    s.author = "Florian Frank"
    s.email = "flori@ping.de"
    s.homepage = "http://flori.github.com/#{PKG_NAME}"
    s.rubyforge_project = PKG_NAME
  end

  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
    pkg.package_files += PKG_FILES
  end
end

desc m = "Writing version information for #{PKG_VERSION}"
task :version do
  puts m
  File.open(File.join('lib', 'dslkit', 'version.rb'), 'w') do |v|
    v.puts <<EOT
module DSLKit
  # DSLKit version
  VERSION         = '#{PKG_VERSION}'
  VERSION_ARRAY   = VERSION.split(/\\./).map { |x| x.to_i } # :nodoc:
  VERSION_MAJOR   = VERSION_ARRAY[0] # :nodoc:
  VERSION_MINOR   = VERSION_ARRAY[1] # :nodoc:
  VERSION_BUILD   = VERSION_ARRAY[2] # :nodoc:
end
EOT
  end
end

desc "Default"
task :default => [ :version, :test ]

desc "Prepare a release"
task :release => [ :clean, :version, :package ]
