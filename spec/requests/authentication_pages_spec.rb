require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do

  subject {page}

  describe "Authentication page" do

    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }

  end

  describe "signin" do

    before {visit signin_path}

    describe "with invalid information" do

      before {click_button "Sign in"}

      it {should have_title "Sign in"}
      it {should have_selector "div.alert.alert-error"}

    end

    describe "with valid information" do

      let(:user){FactoryGirl.create(:user)}

      before() do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it {should have_title user.name}
      it {should have_link 'Profile', href: user_path(user)}
      it { should have_link 'Settings', href: edit_user_path(user) }
      it {should have_link 'Sign out', href: signout_path}
      it {should_not have_link 'Sign out', href: signin_path}

      describe "after visiting another page" do
        before {click_link 'Home'}
        it {should_not have_selector "div.alert.alert-error"}
      end

      describe 'followed by signout' do
        before { click_link 'Sign out' }
        it { should have_link 'Sign in' }
      end

    end

  end

  describe "authorization" do

    describe "for non-signed users" do

      let(:user) { FactoryGirl.create(:user) }

      describe "in Users controller" do

        describe "visiting to edit page" do
          before { visit edit_user_path(user) }

          it { should have_title 'Sign in' }
          it { should have_link 'Sign in', href: signin_path }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to signin_path }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }

      before { sign_in user, no_capybara: true }

      describe 'getting edit page' do
        before { get edit_user_path(wrong_user) }
        specify { expect(response).to redirect_to root_url }
      end

      describe 'updating settings of another user' do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to root_url }
      end

    end

  end

end