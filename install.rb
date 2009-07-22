#!/usr/bin/env ruby

require 'rbconfig'
require 'fileutils'
include FileUtils::Verbose

include Config

src = File.join(*%w[lib dslkit])
dst = File.join(CONFIG["sitelibdir"], 'dslkit')
mkdir_p dst
cd src do
  for file in Dir['*.rb']
    install file, File.join(dst, file)
  end
end
install File.join('lib', 'dslkit.rb'), File.join(CONFIG["sitelibdir"], 'dslkit.rb')
