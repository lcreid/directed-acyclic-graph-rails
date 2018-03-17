ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "capybara/rails"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_dag_test_data
    @all = []
    @all << @person = Person.create(name: "Me")
    @all << @unrelated = Person.create(name: "Unrelated")
    @all << @parent = @person.parents.create(name: "Mother")
    @all << @grandparent = @parent.parents.create(name: "Grandparent")
    @all << @greatgrandparent = @grandparent.parents.create(name: "Great-grandparent")
    @all << @child = @person.children.create(name: "Daughter")
    @all << @grandchild = @child.children.create(name: "Grandchild")
    @all << @greatgrandchild = @grandchild.children.create(name: "Great-grandchild")
  end
end
