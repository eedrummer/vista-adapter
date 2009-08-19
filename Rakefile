require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

test_files_pattern = 'test/**/*_test.rb'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = test_files_pattern
  t.verbose = true
end

spec = Gem::Specification.new do |s| 
  s.name = "vista-adapter"
  s.version = "0.1.0"
  s.author = "hData Team"
  s.email = "hdata-dev-list@lists.mitre.org"
  s.homepage = "http://mitrepedia.mitre.org/index.php/HData"
  s.platform = Gem::Platform::RUBY
  s.summary = "Adapter from VistA to hData"
  s.files = FileList["lib/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = true
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end