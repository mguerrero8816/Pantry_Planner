require 'rails_helper'
require 'testing_methods'

RSpec.feature "ItemNames", type: :feature do
  context 'different registration statuses' do
    Steps 'Item name CRUD as a registered user' do
      When 'I am a registered user' do
        generate_user('user@test.com')
        sign_in_user('user@test.com')
      end
      Then 'I can create a new item name from my dashboard' do
        click_link 'New Item'
        fill_in 'item_name[name]', with: 'tomato'
        click_button 'Create Item'
      end
      And 'I can create a new item name from the list of my items' do
        visit '/my_items'
        click_link 'New Item'
        fill_in 'item_name[name]', with: 'broccoli'
        click_button 'Create Item'
      end
      And 'I can create a new item name from the list of all items' do
        generate_user('user2@test.com')
        click_link 'Sign Out'
        sign_in_user('user2@test.com')
        visit '/all_items'
        click_link 'New Item'
        fill_in 'item_name[name]', with: 'cheese'
        click_button 'Create Item'
      end
      Then 'I can see the item names that I have created in a list' do
        visit '/my_items'
        expect(page).to_not have_content 'tomato'
        expect(page).to_not have_content 'broccoli'
        expect(page).to have_content 'cheese'
      end
      And 'I can see the item names that all users have created in a different list' do
        visit '/all_items'
        expect(page).to have_content 'tomato'
        expect(page).to have_content 'broccoli'
        expect(page).to have_content 'cheese'
      end
      Then 'I can update an item name that I have created' do
        visit '/my_items'
        click_link 'cheese'
        click_link 'Edit Name'
        fill_in 'item_name[name]', with: 'pepper'
        click_button 'Update'
        expect(page).to have_content 'pepper'
      end
      When 'I try to access the page to update an item name that I have not created' do
        new_item_id = generate_item('milk')
        visit "/item_names/#{new_item_id}/edit"
      end
      Then 'I am returned to the previous page with a warning' do
        expect(page).to have_content ''
      end
      And 'I can delete an item name that I have created' do
        visit '/my_items'
        click_link 'pepper'
        click_link 'Delete'
        visit '/my_items'
        expect(page).to_not have_content 'pepper'
      end
      When 'I try to delete an item that I have not created' do
        #TODO
      end
      Then 'I am returned to the previous page with a warning' do
        #TODO
      end
    end

    Steps 'Item name CRUD as an unregistered user' do
      When 'I am an unregistered user' do
        visit '/'
      end
      And 'I try to access the item name creation page' do
        visit '/item_names/new'
      end
      Then 'I am sent to the login page with an alert message' do
        expect(page).to have_content 'Sign In'
        expect(page).to have_content 'Sign in to continue'
      end
      And 'I can see the item names that all users have created in a list' do
        generate_item('tomato')
        visit '/all_items'
        expect(page).to have_content 'tomato'
      end
      And 'I can see the option to create a new item name' do
        expect(page).to have_content 'New Item'
      end
      When 'I try to access the page to update an item name' do
        new_item_id = generate_item('milk')
        visit "/item_name/#{new_item_id}/edit"
      end
      Then 'I am returned to the previous page with a warning' do
        expect(page).to have_content 'Sign In'
        expect(page).to have_content 'Sign in to continue'
      end
      When 'I try to delete an item' do
        #TODO
      end
      Then 'I am returned to the previous page with a warning' do
        #TODO
      end
    end
  end
end
