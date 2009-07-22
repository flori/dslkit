# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'dslkit'
  s.version = '0.2.6'
  s.summary = 'Kit for building DSLs in Ruby'
  s.description = 'This library contains recurring patterns, that are useful in the creation of internal Domain Specific Languages (DSL) in Ruby.'

  s.files = ["CHANGES", "COPYING", "Rakefile", "TODO", "VERSION", "dslkit.gemspec", "examples", "examples/let.rb", "examples/mail.rb", "examples/mm.rb", "examples/multiply.reg", "examples/null_pattern.rb", "examples/recipe.rb", "examples/recipe2.rb", "examples/recipe_common.rb", "examples/subtract.reg", "install.rb", "lib", "lib/dslkit", "lib/dslkit.rb", "lib/dslkit/polite.rb", "lib/dslkit/rude.rb", "lib/dslkit/version.rb", "tests", "tests/runner.rb", "tests/test_common.rb", "tests/test_polite.rb", "tests/test_rude.rb"]

  s.require_path = 'lib'

  s.has_rdoc = true
  s.rdoc_options << '--main' << 'doc-main.txt'
  s.extra_rdoc_files << 'doc-main.txt'
  s.test_files << 'tests/runner.rb'

  s.author = "Florian Frank"
  s.email = "flori@ping.de"
  s.homepage = "http://dslkit.rubyforge.org"
  s.rubyforge_project = "dslkit"
end
