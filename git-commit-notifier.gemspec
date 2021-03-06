# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{git-commit-notifier}
  s.version = IO.read('VERSION').chomp

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bodo Tasche"]
  s.date = %q{2011-04-05}
  s.default_executable = %q{git-commit-notifier}
  s.description = %q{This git commit notifier sends html mails with nice diffs for every changed file.}
  s.email = %q{bodo@bitboxer.de}
  s.executables = ["git-commit-notifier"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.textile"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE",
    "README.textile",
    "Rakefile",
    "VERSION",
    "bin/git-commit-notifier",
    "config/git-notifier-config.yml.sample",
    "git-commit-notifier.gemspec",
    "lib/git_commit_notifier.rb",
    "lib/git_commit_notifier/commit_hook.rb",
    "lib/git_commit_notifier/diff_callback.rb",
    "lib/git_commit_notifier/diff_to_html.rb",
    "lib/git_commit_notifier/emailer.rb",
    "lib/git_commit_notifier/escape_helper.rb",
    "lib/git_commit_notifier/executor.rb",
    "lib/git_commit_notifier/git.rb",
    "lib/git_commit_notifier/logger.rb",
    "lib/git_commit_notifier/result_processor.rb",
    "local-run.rb",
    "spec/fixtures/existing_file_one_line.txt",
    "spec/fixtures/git-notifier-group-email-by-push.yml",
    "spec/fixtures/git-notifier-ignore-merge.yml",
    "spec/fixtures/git-notifier-with-branch-restrictions.yml",
    "spec/fixtures/git-notifier-with-merge.yml",
    "spec/fixtures/git_log",
    "spec/fixtures/git_show_055850e7d925110322b8db4e17c3b840d76e144c",
    "spec/fixtures/git_show_51b986619d88f7ba98be7d271188785cbbb541a0",
    "spec/fixtures/git_show_a4629e707d80a5769f7a71ca6ed9471015e14dc9",
    "spec/fixtures/git_show_dce6ade4cdc2833b53bd600ef10f9bce83c7102d",
    "spec/fixtures/git_show_e28ad77bba0574241e6eb64dfd0c1291b221effe",
    "spec/fixtures/git_show_ff037a73fc1094455e7bbf506171a3f3cf873ae6",
    "spec/fixtures/new_file_one_line.txt",
    "spec/lib/git_commit_notifier/commit_hook_spec.rb",
    "spec/lib/git_commit_notifier/diff_to_html_spec.rb",
    "spec/lib/git_commit_notifier/emailer_spec.rb",
    "spec/lib/git_commit_notifier/git_spec.rb",
    "spec/lib/git_commit_notifier/logger_spec.rb",
    "spec/lib/git_commit_notifier/result_processor_spec.rb",
    "spec/spec_helper.rb",
    "template/email.html.erb",
    "template/styles.css"
  ]
  s.homepage = %q{http://github.com/bitboxer/git-commit-notifier}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Sends git commit messages with diffs}
  s.test_files = [
    "spec/lib/git_commit_notifier/commit_hook_spec.rb",
    "spec/lib/git_commit_notifier/diff_to_html_spec.rb",
    "spec/lib/git_commit_notifier/emailer_spec.rb",
    "spec/lib/git_commit_notifier/git_spec.rb",
    "spec/lib/git_commit_notifier/logger_spec.rb",
    "spec/lib/git_commit_notifier/result_processor_spec.rb",
    "spec/spec_helper.rb"
  ]

  s.specification_version = 3

  s.add_runtime_dependency(%q<diff-lcs>, [">= 0"])
  s.add_runtime_dependency(%q<nntp>, [">= 0"])
  s.add_runtime_dependency(%q<premailer>, [">= 1.7.1"])
  s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.4"])
  s.add_development_dependency(%q<bundler>, [">= 1.0"])
  s.add_development_dependency(%q<code-cleaner>, [">= 0"])
  s.add_development_dependency(%q<rspec-core>, [">= 0"])
  s.add_development_dependency(%q<rspec-expectations>, [">= 0"])
  s.add_development_dependency(%q<rr>, [">= 0"])
  s.add_development_dependency(%q<faker>, [">= 0"])
  s.add_development_dependency(%q<rcov>, [">= 0"])
  s.add_development_dependency(%q<metric_fu>, [">= 0"])
end

