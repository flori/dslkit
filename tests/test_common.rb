require 'test/unit'
require 'tempfile'

class TC_DSLKit < Test::Unit::TestCase
  def setup
    @tl = TL.new
    @tl2 = TL.new
    @ie = IE.new { foo }
    @c  = C.new
    @da = DA.new
    @i  = I.new
  end

  def test_thread_local
    assert_nil @tl.foo
    @tl.foo = 1
    assert_equal 1, @tl.foo
    new_foo = nil
    thread = Thread.new do
      @tl.foo = 2
      new_foo = @tl.foo
    end
    thread.join
    assert_equal 2, new_foo
    assert_equal 1, @tl.foo
    assert_equal @tl.baz, @tl2.baz
  end

  def test_instance_thread_local
    assert_nil @tl.baz
    @tl.baz = 1
    assert_equal 1, @tl.baz
    new_foo = nil
    thread = Thread.new do
      @tl.baz = 2
      new_foo = @tl.baz
    end
    thread.join
    assert_equal 2, new_foo
    assert_equal 1, @tl.baz
    assert_not_equal @tl.baz, @tl2.baz
  end

  def test_thread_global
    assert_nil @tl.bar
    @tl.bar = 1
    assert_equal 1, @tl.bar
    new_bar = nil
    thread = Thread.new do
      @tl.bar = 2
      new_bar = @tl.bar
    end
    thread.join
    assert_equal 2, new_bar
    assert_equal 2, @tl.bar
  end

  def test_instance_exec
    assert_equal :foo, @ie.foo
    assert_equal :foo, @ie.exec
    @ie.freeze
    assert_equal :foo, @ie.foo
    assert_equal :foo, @ie.exec
  end

  def test_constant
    assert_equal :foo, @c.foo
    assert_equal :baz, @c.bar
  end

  def test_dsl_accessor
    assert_nil @da.foo
    assert_equal :bar, @da.bar
    assert_equal :baz, @da.baz
    assert_equal [:qu, :ux], @da.quux
    @da.foo 1
    @da.bar 2
    @da.baz 3
    assert_equal 1, @da.foo
    assert_equal 2, @da.bar
    assert_equal 3, @da.baz
  end

  def test_dsl_reader
    assert_equal true, @da.on
    assert_equal false, @da.off
    assert_raises(ArgumentError) do
      @da.on false
    end
    assert_equal [ @da.on, @da.off ], @da.states
    assert_equal %w[a b c], @da.abc
    @da.abc << 'd'
    assert_equal %w[a b c d], @da.abc
    @da.instance_variable_set :@abc, %w[a b c]
    assert_equal %w[a b c], @da.abc
  end

  def test_dsl_accessor_multiple
    assert_nil @da.foo
    assert_equal :bar, @da.bar
    @da.foo 1, 2
    @da.bar [1, 2]
    assert_equal [1, 2], @da.foo
    assert_equal [1, 2], @da.bar
    @da.bar [1, 2, *@da.bar]
    assert_equal [1, 2] * 2, @da.bar
  end

  def test_interpreter
    assert_equal :foo, @i.interpret('foo')
    temp = Tempfile.new('foo')
    temp.write 'foo'
    temp.rewind
    assert_equal :foo, @i.interpret(temp)
  end

  def test_interpreter_with_args
    assert_equal 3, @i.interpret('|x| x + y', 1)
    temp = Tempfile.new('foo')
    temp.write '|x| x + y'
    temp.rewind
    assert_equal 3, @i.interpret(temp, 1)
  end

  def test_symbol_maker
    if defined? S
      s = S.new
      assert_equal(:foo, s.instance_exec { foo })
      assert_raises(NoMethodError) { s.instance_exec { foo 1 }}
    end
  end

  def test_constant_maker
    if defined? K
      assert_equal(:FOO, K::FOO)
    end
  end

  def test_deflect_block
    assert_raises(NoMethodError) { 1.foo }
    assert !D.deflect?(Integer, :foo)
    D.deflect(Integer, :foo, DSLKit::Deflect::Deflector.new { :foo }) do
      assert_equal :foo, 1.foo
      assert D.deflect?(Integer, :foo)
    end
    assert !D.deflect?(Integer, :foo)
    assert_raises(NoMethodError) { 1.foo }
  end

  def test_deflect
    assert_raises(NoMethodError) { 1.foo }
    assert !D.deflect?(Integer, :foo)
    D.deflect_start(Integer, :foo, DSLKit::Deflect::Deflector.new { :foo })
    assert_equal :foo, 1.foo
    assert D.deflect?(Integer, :foo)
    t = Thread.new do
      assert !D.deflect?(Integer, :foo)
      assert_raises(NoMethodError) { 1.foo }
    end
    t.join
    D.deflect_stop(Integer, :foo)
    assert !D.deflect?(Integer, :foo)
    assert_raises(NoMethodError) { 1.foo }
  end

  def test_deflect_method_missing
    assert_raises(NoMethodError) { 1.foo }
    assert !D.deflect?(Integer, :method_missing)
    D.deflect_start(Integer, :method_missing, DSLKit::Deflect::Deflector.new { :foo })
    assert_equal :foo, 1.foo
    assert D.deflect?(Integer, :method_missing)
    t = Thread.new do
      assert !D.deflect?(Integer, :method_missing)
      assert_raises(NoMethodError) { 1.foo }
    end
    t.join
    D.deflect_stop(Integer, :method_missing)
    assert !D.deflect?(Integer, :method_missing)
    assert_raises(NoMethodError) { 1.foo }
  end

  def test_delegate
    d = D2.new
    assert_equal 3, d.my_size1
    assert_equal 3, d.my_size2
    assert_equal 3, d.size
    assert_equal 3, d.length
  end

  if defined? D3
    def test_delegate
      d = D3.new []
      assert_equal 0, d.size
      d.push 1
      assert_equal [1], d.map { |x| x }
      d.push 2
      assert_equal [1, 2], d.map { |x| x }
      d.push 3
      assert_equal [1, 2, 3], d.map { |x| x }
    end
  end
end
