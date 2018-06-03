require "rspec/core/rake_task"

RSpec::Core::RakeTask.new("spec")

desc 'Registers lib/template.rb'
task :register_template do
  sh 'bundle exec atcoder_greedy template -a lib/template.rb'
end
