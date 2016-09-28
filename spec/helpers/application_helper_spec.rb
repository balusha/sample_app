require 'rails_helper'

describe ApplicationHelper do

  describe 'full_title' do
    it 'should include the page title' do
      expect(full_title('Sign up')).to match(/Rails Sample : Sign up/)
      expect(full_title('Home')).to match(/Rails Sample/)
    end
  end
end