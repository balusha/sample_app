require 'rails_helper'

RSpec.describe "UserPages", type: :request do

  subject { page }

  describe "Sign up page" do

    before {visit signup_path}

    let(:submit){'Click to submit'}

    describe "with invalid information" do
      it "should not create a user" do
        expect{click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Ololosha"
        fill_in "Email", with: "ololo@sha.ru"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect{ click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('ololo@sha.ru') }

        it do
          should have_link "Sign out"
        end
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

      end
    end

    it{should have_content 'Sign up'}
    it{should have_title 'Sign up'}

  end

  describe "profile page" do

    let(:user){FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it{should have_content user.name}
    it{should have_title user.name}

  end

end
