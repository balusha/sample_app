require 'rails_helper'

RSpec.describe "MicropostPages", type: :request do

	subject { page }

	let(:user) { FactoryGirl.create :user }
	before { sign_in user }

	describe "micropost creation" do

		before { visit root_url }

		describe "with invalid info" do
			it "shouldn`t create micropost" do
				expect { click_button "Post it!" }.not_to change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post it!" }
				it { should have_content "error" }
			end

		end

		describe "with valid info" do
			before { fill_in "micropost_content", with: "Lorem ipsum" }
			it "should create a micropost" do
				expect { click_button "Post it!" }.to change(Micropost, :count).by(1)
			end
		end

	end

	describe "micropost destruction" do

		let!(:micropost) { FactoryGirl.create :micropost, user: user }
		before { visit user_path(user) }

		describe "as correct user" do
			it "should delete micropost" do
				expect { click_link "delete" }.to change(Micropost, :count).by(-1)
			end
		end
	end
end
