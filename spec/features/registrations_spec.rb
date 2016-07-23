require 'rails_helper'
require 'testing_methods'

RSpec.feature "Registrations", type: :feature do
  context 'Different registration statuses' do
    Steps 'navigating the site as an unregistered user' do
      When 'I visit the website' do
        visit '/'
      end
      Then 'I should see the landing page' do
        expect(page).to have_content 'Welcome to'
      end
      And 'I can click the link to sign in' do
        click_link 'Sign In'
      end
      When 'I return to the landing page' do
        visit '/'
      end
      Then 'I can click the link to sign up for an account' do
        click_link 'Sign Up'
      end
      When 'I register for an account' do
        create_user('user@test.com')
      end
      Then 'I am taken to my pantry page' do
        expect(page).to have_content 'Your Pantry'
      end
      And 'I can log out and am taken to the landing page' do
        click_link 'Sign Out'
        expect(page).to have_content 'Welcome to'
      end
      When 'I log in' do
        sign_in_user('user@test.com')
      end
      Then 'I am taken to my pantry page' do
        expect(page).to have_content 'Your Pantry'
      end
    end

    Steps 'navigating the site as a registered user' do
      When 'I visit the site after logging in' do
        visit '/'
        generate_user('user@test.com')
        sign_in_user('user@test.com')
        visit 'https://www.google.com'
        visit '/'
      end
      Then 'I should be taken to my pantry page' do
        expect(page).to have_content 'Your Pantry'
      end
    end
  end
end
