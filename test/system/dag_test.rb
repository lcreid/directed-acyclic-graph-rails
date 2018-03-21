require "application_system_test_case"

class DagTest < ApplicationSystemTestCase
  def setup
    create_dag_test_data
    @person.children.delete(@child)
    @person.parents.delete(@parent)
  end

  test "person unconnected" do
    visit edit_person_path(@person)

    within "ul.js-children" do
      @all.reject { |p| p == @person }.each do |p|
        assert_unchecked_field(p.name)
      end
      assert_no_field(@person.name)
    end

    within "ul.js-parents" do
      @all.reject { |p| p == @person }.each do |p|
        assert_unchecked_field(p.name)
      end
      assert_no_field(@person.name)
    end
  end

  test "connect person to child" do
    visit edit_person_path(@person)

    within "ul.js-children" do
      check(@child.name)
      puts page.driver.browser.manage.logs.get(:browser)

      @all.reject { |p| [@person, @child].include?(p) }.each do |p|
        assert_unchecked_field(p.name)
      end
      assert_no_field(@person.name)
      assert_checked_field @child.name
    end

    within "ul.js-parents" do
      @all.reject { |p| p == @person }.each do |p|
        assert_unchecked_field(p.name, disabled: [
          @child, @grandchild, @greatgrandchild
        ].include?(p))
      end
      assert_no_field(@person.name)
    end
  end

  test "connect person to parent" do
    visit edit_person_path(@person)

    within "ul.js-parents" do
      check(@parent.name)
      puts page.driver.browser.manage.logs.get(:browser)

      @all.reject { |p| [@person, @parent].include?(p) }.each do |p|
        assert_unchecked_field(p.name)
      end
      assert_no_field(@person.name)
      assert_checked_field @parent.name
    end

    within "ul.js-children" do
      @all.reject { |p| p == @person }.each do |p|
        assert_unchecked_field(p.name, disabled: [
          @parent, @grandparent, @greatgrandparent
        ].include?(p))
      end
      assert_no_field(@person.name)
    end
  end

  test "disconnect person from child" do
    @person.children << @child
    visit edit_person_path(@person)
    within "ul.js-children" do
      uncheck(@child.name)
      puts page.driver.browser.manage.logs.get(:browser)
    end

    within "ul.js-parents" do
      @all.reject { |p| p == @person }.each do |p|
        assert_unchecked_field(p.name)
      end
      assert_no_field(@person.name)
    end
  end

  test "disconnect person from parent" do
    @person.parents << @parent
    visit edit_person_path(@person)
    within "ul.js-parents" do
      uncheck(@parent.name)
      puts page.driver.browser.manage.logs.get(:browser)
    end

    within "ul.js-children" do
      @all.reject { |p| p == @person }.each do |p|
        assert_unchecked_field(p.name)
      end
      assert_no_field(@person.name)
    end
  end
end
