# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dslkit"
  s.version = "0.2.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = "2013-06-11"
  s.description = "This library contains recurring patterns, that are useful in the creation of internal Domain Specific Languages (DSL) in Ruby."
  s.email = "flori@ping.de"
  s.extra_rdoc_files = ["README.rdoc", "lib/dslkit.rb", "lib/dslkit/polite.rb", "lib/dslkit/rude.rb", "lib/dslkit/version.rb"]
  s.files = [".gitignore", ".travis.yml", "CHANGES", "COPYING", "Gemfile", "README.rdoc", "Rakefile", "TODO", "VERSION", "dslkit.gemspec", "examples/add_one.png", "examples/add_one.stm", "examples/bb3.png", "examples/bb3.stm", "examples/bb3_19.stm", "examples/concatenate_compare.mtm", "examples/concatenate_compare.png", "examples/concatenate_compare_19.mtm", "examples/length_difference.mtm", "examples/length_difference.png", "examples/length_difference_19.mtm", "examples/let.rb", "examples/mail.rb", "examples/minsky.rb", "examples/multiply.reg", "examples/null_pattern.rb", "examples/ones_difference-mtm.png", "examples/ones_difference-stm.png", "examples/ones_difference.mtm", "examples/ones_difference.stm", "examples/ones_difference_19.mtm", "examples/ones_difference_19.stm", "examples/prefix-equals-suffix-reversed-with-infix.png", "examples/prefix-equals-suffix-reversed-with-infix.stm", "examples/prefix-equals-suffix-reversed-with-infix_19.stm", "examples/recipe.rb", "examples/recipe2.rb", "examples/recipe_common.rb", "examples/subtract.reg", "examples/turing-graph.rb", "examples/turing.rb", "lib/dslkit.rb", "lib/dslkit/polite.rb", "lib/dslkit/rude.rb", "lib/dslkit/version.rb", "tests/concern_test.rb", "tests/dynamic_scope_test.rb", "tests/from_module_test.rb", "tests/polite_test.rb", "tests/scope_test.rb", "tests/test_helper.rb"]
  s.homepage = "http://flori.github.com/dslkit"
  s.rdoc_options = ["--title", "Dslkit - Kit for building DSLs in Ruby", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Kit for building DSLs in Ruby"
  s.test_files = ["tests/concern_test.rb", "tests/dynamic_scope_test.rb", "tests/from_module_test.rb", "tests/polite_test.rb", "tests/scope_test.rb", "tests/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.1.8"])
      s.add_development_dependency(%q<utils>, [">= 0"])
      s.add_runtime_dependency(%q<term-ansicolor>, ["~> 1.0"])
      s.add_runtime_dependency(%q<tins>, ["~> 0.6"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.1.8"])
      s.add_dependency(%q<utils>, [">= 0"])
      s.add_dependency(%q<term-ansicolor>, ["~> 1.0"])
      s.add_dependency(%q<tins>, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.1.8"])
    s.add_dependency(%q<utils>, [">= 0"])
    s.add_dependency(%q<term-ansicolor>, ["~> 1.0"])
    s.add_dependency(%q<tins>, ["~> 0.6"])
  end
end
