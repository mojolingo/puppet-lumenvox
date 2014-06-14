require 'rake'
require 'rspec/core/rake_task'

desc "Run all RSpec code examples"
RSpec::Core::RakeTask.new(:rspec) do |t|
  if File.exist?('spec/spec.opts')
    t.rspec_opts = File.read("spec/spec.opts").chomp || ''
  else
    t.rspec_opts = ''
  end
end

SPEC_SUITES = (Dir.entries('spec') - ['.', '..','fixtures']).select {|e| File.directory? "spec/#{e}" }
namespace :rspec do
  SPEC_SUITES.each do |suite|
    desc "Run #{suite} RSpec code examples"
    RSpec::Core::RakeTask.new(suite) do |t|
      t.pattern = "spec/#{suite}/**/*_spec.rb"
      if File.exist?('spec/spec.opts')
        t.rspec_opts = File.read("spec/spec.opts").chomp || ''
      else
        t.rspec_opts = ''
      end
    end
  end
end
task :default => :rspec

begin
  if Gem::Specification::find_by_name('puppet-lint')
    require 'puppet-lint/tasks/puppet-lint'
    PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
    PuppetLint.configuration.send("disable_80chars")

    task :default => [:rspec, :lint]
  end
rescue Gem::LoadError
end
