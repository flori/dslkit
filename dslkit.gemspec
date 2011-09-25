# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dslkit"
  s.version = "0.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = "2011-09-25"
  s.description = "This library contains recurring patterns, that are useful in the creation of internal Domain Specific Languages (DSL) in Ruby."
  s.email = "flori@ping.de"
  s.extra_rdoc_files = ["README.rdoc", "lib/dslkit/version.rb", "lib/dslkit/rude.rb", "lib/dslkit/polite.rb", "lib/dslkit.rb"]
  s.files = [".gitignore", "CHANGES", "COPYING", "Gemfile", "README.rdoc", "Rakefile", "TODO", "VERSION", "dslkit.gemspec", "examples/add_one.pdf", "examples/add_one.stm", "examples/bb3.pdf", "examples/bb3.stm", "examples/bb3_19.stm", "examples/concatenate_compare.mtm", "examples/concatenate_compare.pdf", "examples/concatenate_compare_19.mtm", "examples/length_difference.mtm", "examples/length_difference.pdf", "examples/length_difference_19.mtm", "examples/let.rb", "examples/mail.rb", "examples/minsky.rb", "examples/multiply.reg", "examples/null_pattern.rb", "examples/ones_difference-mtm.pdf", "examples/ones_difference-stm.pdf", "examples/ones_difference.mtm", "examples/ones_difference.stm", "examples/ones_difference_19.mtm", "examples/ones_difference_19.stm", "examples/prefix-equals-suffix-reversed-with-infix.pdf", "examples/prefix-equals-suffix-reversed-with-infix.stm", "examples/prefix-equals-suffix-reversed-with-infix_19.stm", "examples/recipe.rb", "examples/recipe2.rb", "examples/recipe_common.rb", "examples/subtract.reg", "examples/turing-graph.rb", "examples/turing.rb", "lib/dslkit.rb", "lib/dslkit/polite.rb", "lib/dslkit/rude.rb", "lib/dslkit/version.rb", "tests/test_polite.rb"]
  s.homepage = "http://flori.github.com/dslkit"
  s.rdoc_options = ["--title", "Dslkit - Kit for building DSLs in Ruby", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Kit for building DSLs in Ruby"
  s.test_files = ["tests/test_polite.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.1.0"])
      s.add_runtime_dependency(%q<term-ansicolor>, ["~> 1.0"])
      s.add_runtime_dependency(%q<tins>, ["~> 0.3"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.1.0"])
      s.add_dependency(%q<term-ansicolor>, ["~> 1.0"])
      s.add_dependency(%q<tins>, ["~> 0.3"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.1.0"])
    s.add_dependency(%q<term-ansicolor>, ["~> 1.0"])
    s.add_dependency(%q<tins>, ["~> 0.3"])
  end
end
