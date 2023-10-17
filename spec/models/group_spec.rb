# spec/models/group_spec.rb
require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'Binod', email: 'binod@email.com', password: 'password') }

  it 'is valid with valid attributes' do
    group = Group.new(
      name: 'Sample Group',
      icon: 'icon.png',
      user:
    )
    expect(group).to be_valid
  end

  it 'is not valid without a name' do
    group = Group.new(icon: 'icon.png', user:)
    expect(group).to_not be_valid
  end

  it 'is not valid without an icon' do
    group = Group.new(name: 'Sample Group', user:)
    expect(group).to_not be_valid
  end

  it 'is not valid with a duplicate name for the same user' do
    Group.create(name: 'Sample Group', icon: 'icon.png', user:)
    group = Group.new(name: 'Sample Group', icon: 'another_icon.png', user:)
    expect(group).to_not be_valid
  end
end
