module Dag
  # Be a directed acyclic graph (DAG).
  extend ActiveSupport::Concern

  included do
    has_many :parent_links,
             foreign_key: :child_id,
             class_name: "Edge",
             dependent: :destroy,
             inverse_of: :child
    has_many :parents, through: :parent_links, class_name: "Person"
    accepts_nested_attributes_for :parents, allow_destroy: true

    has_many :child_links,
             foreign_key: :parent_id,
             class_name: "Edge",
             dependent: :destroy,
             inverse_of: :parent
    has_many :children, through: :child_links, class_name: "Person"
    accepts_nested_attributes_for :children, allow_destroy: true

    # @return [Enumerable] all the ancestors of self.
    def ancestors
      parents + parents.map(&:ancestors).flatten
    end

    # @return [Enumerable] self and all the ancestors of self.
    def and_ancestors
      ancestors.prepend(self)
    end

    # @return [Enumerable] all the descendants of self.
    def descendants
      children + children.map(&:descendants).flatten
    end

    # @return [Enumerable] self and all the descendants of self.
    def and_descendants
      descendants.prepend(self)
    end
  end

  class_methods do
  end
end
