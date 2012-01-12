# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'dslkit'
  path_module 'DSLKit'
  author      'Florian Frank'
  email       'flori@ping.de'
  homepage    "http://flori.github.com/#{name}"
  summary     'Kit for building DSLs in Ruby'
  description 'This library contains recurring patterns, that are useful in the creation of internal Domain Specific Languages (DSL) in Ruby.'
  test_dir    'tests'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', '.rvmrc', 'coverage'
  readme      'README.rdoc'

  dependency  'term-ansicolor', '~>1.0'
  dependency  'tins',           '~>0.3'

  install_library do
    libdir = CONFIG["sitelibdir"]
    cd 'lib' do
      dst = File.join(libdir, 'dslkit')
      mkdir_p dst
      cd 'dslkit' do
        for file in Dir['*.rb']
          install file, File.join(dst, file)
        end
      end
      install 'dslkit.rb', libdir
    end
  end
end
