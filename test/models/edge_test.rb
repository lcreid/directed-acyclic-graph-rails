require "test_helper"

class EdgeTest < ActiveSupport::TestCase
  test "link two existing people by making a relationship" do
    parent = people(:parent)
    child = people(:child)
    assert Edge.create(parent: parent, child: child)
  end

  test "link two existing people by assigning to a relationship" do
    parent = people(:parent)
    child = people(:child)
    assert relationship = Edge.new
    relationship.parent = parent
    relationship.child = child
    assert relationship.save
  end

  test "link two existing people by assigning to association" do
    parent = people(:parent)
    child = people(:child)
    assert parent.children << child
    assert_equal child, parent.children.first
    assert_equal parent, child.parents.first
    assert parent.save
    # assert child.save
    # No need to reload.
    assert_equal child, parent.children.first
    assert_equal parent, child.parents.first
  end

  test "link an existing person to a new person by create" do
    parent = people(:parent)
    assert child = parent.children.create(name: "Child")
    assert_equal child, parent.children.first
    assert_equal parent, child.parents.first
    assert parent.save
    # assert child.save
    # No need to reload.
    assert_equal child, parent.children.first
    assert_equal parent, child.parents.first
  end

  test "link an existing person to a new person by build and save" do
    parent = people(:parent)
    assert child = parent.children.build(name: "Child")
    assert_equal child, parent.children.first
    # Note this one is commented out now.
    # assert_equal parent, child.parents.first
    assert parent.save
    # assert child.save
    # No need to reload.
    assert_equal child, parent.children.first
    assert_equal parent, child.parents.first
  end

  # You can't do a parent.children.create until the parent is save, do no test case.

  test "link a new person to a new person by build and save" do
    parent = Person.new(name: "Parent")
    assert child = parent.children.build(name: "Child")
    assert_equal child, parent.children.first
    # Note this one is commented out now.
    # assert_equal parent, child.parents.first
    assert_difference "Person.count", 2 do
      assert_difference "Edge.count" do
        assert parent.save
      end
    end
    # assert child.save
    # No need to reload.
    assert_equal child, parent.children.first
    assert_equal parent, child.parents.first
  end

  test "destroy a relationship" do
    parent = Person.new(name: "Parent")
    assert child = parent.children.build(name: "Child A")
    assert child.save
    assert child = parent.children.build(name: "Child B")
    assert child.save
    assert child = parent.children.build(name: "Child C")
    assert child.save
    # Parent save has to happen when it's all set up.
    assert parent.save

    assert_difference "Person.count", -1 do
      assert_difference "Edge.count", -1 do
        child.destroy
      end
    end

    assert_difference "Person.count", -1 do
      assert_difference "Edge.count", -2 do
        parent.destroy
      end
    end
  end
end
