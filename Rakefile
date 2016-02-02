require "bundler/gem_tasks"
require "rake/testtask"
Bundler::GemHelper.install_tasks

task :test do
  Dir.chdir('test')
end

Rake::TestTask.new(:test) do |t|
  t.libs << '../lib'
  t.libs << '../test'
  t.test_files = FileList['*_test.rb']
  t.verbose = false
end

task :default => :test
