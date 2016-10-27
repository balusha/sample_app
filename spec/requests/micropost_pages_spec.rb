require 'rails_helper'

RSpec.describe "MicropostPages", type: :request do

	subject { page }

	let(:user) { FactoryGirl.create :user }
	before { sign_in user }

end
