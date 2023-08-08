# app/models/province.rb

class Province < ApplicationRecord  
    has_many :orders
    # Validations
    validates :name, presence: true, uniqueness: true
    validates :pst, :hst, :gst, :applicable, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "pst", "hst", "gst", "applicable"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["orders"]
    end
  end
  