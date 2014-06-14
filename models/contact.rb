class Contact
  include Mongoid::Document

  belongs_to :user
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
end
