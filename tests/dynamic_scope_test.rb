require 'dslkit/polite'

class DynamicScopeTest < Test::Unit::TestCase
  include DSLKit::DynamicScope

  def test_dynamic_scoping
    assert_raise(NameError) { foo }
    dynamic_scope do
      assert_raise(NameError) { foo }
      self.foo = 1
      assert_equal 1, foo
      dynamic_scope do
        assert_equal 1, foo
        self.foo = 2
        assert_equal 2, foo
        dynamic_scope do
          assert_equal 2, foo
        end
        assert_equal 2, foo
      end
      assert_equal 1, foo
    end
    assert_raise(NameError) { foo }
  end
end
