require 'spec_helper'

describe Contact, type: :model do
  it { expect(Contact).to belong_to(:user).of_type(User) }
  it { expect(Contact).to have_fields(:first_name, :last_name, :email).of_type(String) }
end
