class User
  include Mongoid::Document

  has_many :contacts
  field :name, type: String
  field :email, type: String

  validates :name, presence: true
  validates :email, presence: true
end
