class Category < ApplicationRecord
    has_many :products

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["id", "name", "description", "created_at", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end
end
