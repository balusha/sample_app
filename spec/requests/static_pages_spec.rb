require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('SAMPLE APP') }
    it { should have_title('Rails Sample') }
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
