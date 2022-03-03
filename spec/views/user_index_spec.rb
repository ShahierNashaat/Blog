require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create! name: 'Shahier', photo: 'avatar.png', password: '123456789', email: 'shahiern@yahoo.com',
                            confirmed_at: Time.now
      @user2 = User.create! name: 'SS2', photo: 'avatar.png', password: '123456', email: 'shahiern2@yahoo.com',
                            confirmed_at: Time.now
      visit new_user_session_path
      fill_in 'Email', with: 'shahiern@yahoo.com'
      fill_in 'Password', with: '123456789'
      click_button 'Log in'
      visit root_path
    end

    it 'shows the username of other users' do
      expect(page).to have_content('Shahier')
      expect(page).to have_content('SS2')
    end

    it 'shows photo' do
      image = page.all('img')
      expect(image.size).to eql(2)
    end

    it 'shows number of posts for each user' do
      expect(page).to have_content('Number of posts: 0')
    end

    it 'show users page when clicked' do
      click_on 'Shahier'
      expect(page).to have_current_path user_path(@user1)
    end
  end
end
