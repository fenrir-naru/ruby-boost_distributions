# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rake/extensiontask"

Rake::ExtensionTask.new("boost_distributions") do |ext|
  ext.lib_dir = "lib/boost_distributions"
end

namespace :git do
  task :version do
    @git_version ||= proc{
      res = Gem::Version::new(`git --version`.match(/\d+\.\d+\.\d+/)[0])
      res.instance_eval{
        cmp_orig = self.method(:<=>)
        define_singleton_method(:<=>){|arg|
          cmp_orig.call(arg.kind_of?(String) ? Gem::Version::new(arg) : arg)
        }
      }
      res
    }.call
  end
  namespace :submodules do
    desc "Initialize git submodules"
    task :init => ["git:version"] do
      sh "git submodule init"
      # for sparse-checkout; @see https://stackoverflow.com/a/59521050/15992898
      `git config --file .gitmodules --name-only --get-regexp path`.lines.each{|str|
        # list submodule; @see https://stackoverflow.com/a/23490756/15992898
        next unless str =~ /submodule\.(.+)\.path/
        repo_dir = $1
        sh "git clone -n #{`git config submodule.#{repo_dir}.url`.chomp} #{repo_dir}"
      }
      {
        'ext/ninja-scan-light' => [
          # From git 2.37.0, cone mode, which denies part of pattern like .ignore, is its default.
          # @see https://git-scm.com/docs/git-sparse-checkout/2.37.0#_internalscone_mode_handling
          (@git_version < "2.37.0") ? "sparse-checkout init" : nil, # same as "git -C #{repo} config core.sparseCheckout true"
          # same as #{repo}/.git/info/sparse-checkout
          "sparse-checkout set #{'--no-cone' if @git_version >= "2.37.0"}" \
              + (<<-__SPARSE_PATTERNS__).lines.collect{|str| str.chomp.gsub(/^ */, ' ')}.join,
            tool/swig/BoostDistributions.i
            tool/swig/makefile
            tool/swig/extconf.rb
          __SPARSE_PATTERNS__
        ].compact
      }.each{|repo, commands|
        commands.each{|str| sh "git -C #{repo} #{str}"}
      }
      sh "git submodule absorbgitdirs" # Move #{repo}/.git to .git/modules/#{repo}/.git
      sh "git submodule update"
      # if already checked out, then git -C #{repo} read-tree -mu HEAD
    end
  end
end


desc "Generate SWIG wrapper codes"
task :swig, [:swig_options] do |task, args|
  swig_dir = File::join(File::dirname(__FILE__), 'ext', 'ninja-scan-light', 'tool', 'swig')
  out_base_dir = File::join(File::dirname(__FILE__), 'ext', 'boost_distributions')
  Dir::chdir(swig_dir){
    Dir::glob("*.i"){|src|
      mod_name = File::basename(src, '.*')
      out_dir = File::join(out_base_dir, mod_name)
      sh "mkdir -p #{out_dir}"
      wrapper = File::join(out_dir, "#{mod_name}_wrap.cxx")
      sh [:make, :clean, wrapper,
          "BUILD_DIR=#{out_dir}",
          "SWIGFLAGS='-c++ -ruby #{" -D__MINGW__" if ENV["MSYSTEM"]} #{args[:swig_options]}'"].join(' ')
    }
  }
end

file "ext/ninja-scan-light/tool" do |t|
  Rake::Task["git:submodules:init"].invoke
end

task :default => ["ext/ninja-scan-light/tool", :compile, :spec]