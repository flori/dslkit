require 'dslkit/polite'
require 'test/unit'

class FromModuleTest < Test::Unit::TestCase
  module MyIncludedModule
    def foo
      :foo
    end

    def bar
      :bar
    end
  end

  class MyKlass
    def foo
      :original_foo
    end

    def bar
      :original_bar
    end
  end

  class DerivedKlass < MyKlass
    extend DSLKit::FromModule

    include from_module MyIncludedModule, :foo
  end

  module MyModule
    def foo
      :original_foo
    end

    def bar
      :original_bar
    end
    include MyIncludedModule
  end

  class AnotherDerivedKlass
    include MyModule

    extend DSLKit::FromModule

    include from_module MyIncludedModule, :foo
  end

  def test_derived_klass
    c = DerivedKlass.new
    assert_equal :foo, c.foo
    assert_equal :original_bar, c.bar
  end

  def test_another_derived_klass
    c = AnotherDerivedKlass.new
    assert_equal :foo, c.foo
    assert_equal :original_bar, c.bar
  end
end
