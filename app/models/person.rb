class Person < ApplicationRecord
  include Dag

  validates :name, presence: true

  def address_types
    address_people.map(&:address_type).uniq
  end

  def to_json
    pp as_json.merge(addresses: addresses.as_json).merge(phones: phones.as_json)
  end
end
