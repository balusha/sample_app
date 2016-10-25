require 'rails_helper'

RSpec.describe Micropost, type: :model do
  
	let(:user) { FactoryGirl.create(:user) }
	before { @micropost = Micropost.new(user_id: user.id, content: 'Lorem ipsum') }

	subject { @micropost }

	it { should respond_to :user_id }
	it { should respond_to :content }
	it { should respond_to :user }

	describe "when user isn`t present" do
	  before { @micropost.user_id = nil }
	  it { should_not be_valid }
	end

	describe "when content isn`t present" do
	  before { @micropost.content = '' }
	  it { should_not be_valid }
	end

	describe "when content`s length exceed 140 chars " do
	  before { @micropost.content = 'a'*141 }
	  it { should_not be_valid }
	end

end
