require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = false
  t.verbose = false
  t.test_files = FileList['spec/integration/*_spec.rb']
end