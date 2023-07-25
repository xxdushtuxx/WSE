class Customer < ApplicationRecord
  belongs_to :province
  has_secure_password
  validates :first_name, :last_name, :email, :phone, :address, :city, :postal_code, presence: true
  validates :first_name, :last_name, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A[\d\+\-\(\)]+\z/, message: "only allows digits, +, -, (, and )" }
  validates :email, uniqueness: true
  validates :postal_code, presence: true, format: { with: /\A[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ -]?\d[ABCEGHJ-NPRSTV-Z]\d\z/i }

  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "first_name", "id", "last_name", "phone", "postal_code", "province_id", "updated_at", "password_digest"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end
end
