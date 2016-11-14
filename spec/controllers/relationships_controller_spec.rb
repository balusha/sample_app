require 'rails_helper'
require 'support/utilities'

RSpec.describe RelationshipsController, type: :controller do

  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }

  before { sign_in user, no_capybara: true }

  describe "creating relationships with Ajax" do

    it "should increment relationships count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      expect(response).to be_success
    end

  end

  describe "destroying relationships with Ajax" do

    before do
      user.follow! other_user
    end

    let(:relationship) { user.relationships.find_by(followed_id: other_user.id) }

    it "should decrement the Relationship count" do
      expect { xhr :delete, :destroy, id: relationship.id }.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end
