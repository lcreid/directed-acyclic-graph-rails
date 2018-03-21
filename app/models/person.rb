class Person < ApplicationRecord
  include Dag

  validates :name, presence: true
end
