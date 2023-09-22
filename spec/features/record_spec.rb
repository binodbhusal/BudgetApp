require 'rails_helper'

RSpec.feature 'Expense Record Details', type: :feature do
  let(:user) { User.create(name: 'Binod', email: 'binod@example.com', password: 'password') }
  let(:group) { Group.create(name: 'Category Name', icon: 'icons/01.png', user:) }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    sleep 1
  end

  scenario 'User views the expense record details' do
    record1 = Record.create(name: 'Record 1', amount: 100, user:, groups: [group])
    record2 = Record.create(name: 'Record 2', amount: 150, user:, groups: [group])

    visit group_records_path(group)

    expect(page).to have_content(group.name.capitalize)
    expect(page).to have_content("TOTAL:$ #{group.total_amount}")
    expect(page).to have_content(record1.name.capitalize)
    expect(page).to have_content("$#{record1.amount}")
    expect(page).to have_content(record2.name.capitalize)
    expect(page).to have_content("$#{record2.amount}")
    expect(page).to have_link('ADD RECORD', href: new_group_record_path(group))
    click_link 'ADD RECORD'
    expect(page).to have_content('NEW EXPENSE')
    expect(page).to have_field('Expense Name')
    fill_in 'Expense Name', with: 'New Expense Name'
    expect(page).to have_field('Amount')
    fill_in 'Amount', with: 20
    click_button 'NEXT'
    expect(page).to have_content('Record created')
  end
end
