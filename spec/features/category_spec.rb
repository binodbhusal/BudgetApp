require 'rails_helper'

RSpec.feature 'User views the category list and creates a category', type: :feature do
  let(:user) { User.create(name: 'Binod', email: 'binod@example.com', password: 'password') }
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    sleep 1
  end
  scenario 'User navigates to the categories page and creates a new category' do
    visit groups_path
    expect(page).to have_content('CATEGORIES')
    click_link 'ADD NEW CATEGORY'
    expect(page).to have_content('ADD CATEGORY')
    expect(page).to have_field('Category Name')
    fill_in 'Category Name', with: 'New Category Name'
    choose('icon_icons_01.png')
    click_button 'Next'
    expect(page).to have_content('Category created')
  end
end
