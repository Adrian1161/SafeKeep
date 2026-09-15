# frozen_string_literal: true

require 'rspec/rails'
require_relative '../../config/environment'
#Test cases for Account model
RSpec.describe 'Account' do
  describe 'Account' do
    it "should be defined" do
      expect {Account}.not_to raise_error
    end
    describe "created an account" do
      before(:each) do
        @account = Account.new(
          username: 'test',
          password: 'test1234'
        )
      end
      it "should set the username" do
        expect(@account.username).to eq('test')
      end
      it "should accept a valid username and password" do
        expect(@account).to be_valid
      end
    end
    describe "username validation" do
      it "should reject an account without a username" do
        account = Account.new(password: 'test1234')
        expect(account).not_to be_valid
      end
    end
  end
end
