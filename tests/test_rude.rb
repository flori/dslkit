$:.unshift '../lib'
$:.unshift 'tests'
require 'dslkit/rude'

class TL
  def initialize
    make_baz
  end

  thread_local :foo

  def make_baz
    instance_thread_local :baz
  end

  thread_global :bar
end

class IE
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
  constant :foo

  constant :bar, :baz
end

class DA
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
  def foo
    :foo
  end

  def y
    2
  end
end

module D
end

class D2
  def initialize
    @ary = [ 1, 2, 3 ]
  end
  attr_reader :ary

  delegate :my_size1, :@ary, :size
  delegate :my_size2, :ary, :size
  delegate :size, :@ary
  delegate :length, :ary
end

require 'test_common'
