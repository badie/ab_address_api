require 'spec_helper'

describe User, type: :model do
  it { expect(User).to have_fields(:name, :email).of_type(String) }
  it { expect(User).to have_many :contacts }
end
