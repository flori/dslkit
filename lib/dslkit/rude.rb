# This file contains some "rude" defaults that tamper with Ruby's open classes
# to augment them with DSLKit methods. Although this shouldn't break anything, it's
# perhaps better to require 'dslkit/polite' instead and include/extend your
# classes with a finer granularity.
require 'dslkit/polite'

module DSLKit
  class ::Module
    include DSLKit::Constant
    include DSLKit::DSLAccessor
    include DSLKit::ClassMethod
    include DSLKit::Delegate
    include DSLKit::ParameterizedModule
    include DSLKit::FromModule
  end

  class ::Object
    include DSLKit::ThreadLocal
    include DSLKit::ThreadGlobal
    include DSLKit::InstanceExec
    include DSLKit::Interpreter
    include DSLKit::Deflect
    include DSLKit::ThreadLocal
    include DSLKit::Eigenclass
    include DSLKit::BlockSelf
  end
end
