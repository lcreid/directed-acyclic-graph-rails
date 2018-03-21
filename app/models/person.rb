class Person < ApplicationRecord
  include Dag

  scope :all_except, -> (person) { where.not(id: person.is_a?(Person) ? person.id : person) }

  validates :name, presence: true
end
