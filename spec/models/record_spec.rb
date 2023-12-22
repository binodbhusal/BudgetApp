# spec/models/record_spec.rb

require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:user) { User.create(name: 'Binod', email: 'binod@email.com', password: 'password') }

  it 'is valid with valid attributes' do
    record = Record.new(
      name: 'Sample Record',
      amount: 100.0,
      user:
    )
    expect(record).to be_valid
  end

  it 'is not valid without a name' do
    record = Record.new(amount: 100.0, user:)
    expect(record).to_not be_valid
  end

  it 'is not valid without an amount' do
    record = Record.new(name: 'Sample Record', user:)
    expect(record).to_not be_valid
  end
end
