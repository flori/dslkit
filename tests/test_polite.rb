$:.unshift '../lib'
$:.unshift 'tests'
require 'dslkit/polite'

class TL
  def initialize
    make_baz
  end

  extend DSLKit::ThreadLocal
  thread_local :foo

  include DSLKit::ThreadLocal
  def make_baz
    instance_thread_local :baz
  end

  extend DSLKit::ThreadGlobal
  thread_global :bar
end

class IE
  include DSLKit::InstanceExec

  def initialize(&block)
    @block = block
  end

  def exec
    instance_exec(&@block)
  end

  def foo
    :foo
  end
end

class C
  extend DSLKit::Constant

  constant :foo

  constant :bar, :baz
end

class DA
  extend DSLKit::DSLAccessor

  dsl_accessor :foo

  dsl_accessor :bar, :bar

  dsl_accessor :baz do :baz end

  dsl_accessor :quux, :qu, :ux

  dsl_reader :on, true 

  dsl_reader :off, false

  dsl_reader :states do
    [ on, off ]
  end

  dsl_reader :abc, *%w[a b c]
end

class I
  include DSLKit::Interpreter

  def foo
    :foo
  end
  
  def y
    2
  end
end

class S
  include DSLKit::InstanceExec
  include DSLKit::SymbolMaker
end

module K
  extend DSLKit::ConstantMaker
end

module D
  extend DSLKit::Deflect
end

class D2
  extend DSLKit::Delegate

  def initialize
    @ary = [ 1, 2, 3 ]
  end
  attr_reader :ary

  delegate :my_size1, :@ary, :size
  delegate :my_size2, :ary, :size
  delegate :size, :ary
  delegate :length, :ary
end

class D3 < DSLKit::MethodMissingDelegator::DelegatorClass
end

require 'test_common'
