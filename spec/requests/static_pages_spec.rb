require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do

  subject { page }

  describe "Home page" do

    before { visit root_path }
    it { should have_content('SAMPLE APP') }
    it { should have_title('Rails Sample') }

    describe "for signed-in users" do

      let(:user) { FactoryGirl.create(:user) }

      before do

        FactoryGirl.create :micropost, user: user, content: "Lorem ipsum"
        FactoryGirl.create :micropost, user: user, content: "Bla bla blaa"

        sign_in user
        visit root_url

      end

      it "should render the user`s feed" do
        user.feed.each do |item|
          expect(page).to have_selector "li##{item.id}", text: item.content
        end
      end

      it "should have sidebar with mposts count" do
        expect(page).to have_selector("aside", text: "#{user.microposts.count} #{"micropost".pluralize(user.microposts.count)}")
      end

      describe "pagination" do

        before do
          35.times { FactoryGirl.create :micropost, user: user }
          visit root_url
        end

        it { should have_selector "div.pagination" }

        it "should list each post" do
          user.microposts.paginate(page: 1).each do |micropost|
            expect(page).to have_selector "li##{micropost.id}"
          end
        end
      end
    end
  end


  describe "Help page" do

    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title('Help') }

  end

  describe "About page" do

    before { visit about_path }

    it { should have_content('About') }
    it { should have_title('About') }

  end

  describe "Contacts page" do

    before { visit contacts_path }

    it { should have_content('Contact Us') }
    it { should have_title('Contact Us') }

  end

end
