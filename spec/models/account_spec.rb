# frozen_string_literal: true

require_relative '../rails_helper'
#Test cases for Account model
RSpec.describe 'Account' do
  describe 'Account' do
    it "should be defined" do
      expect {Account}.not_to raise_error
    end
    describe "created an account" do
      before(:each) do
        @account = Account.new(
          account_id: 'test-account-1',
          username: 'test',
          password: 'test1234',
          pin: '1234',
          recovery_phrase: 'random test recovery phrase'
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
        account = Account.new(
          account_id: 'test-account-2',
          password: 'test1234',
          pin: '1234',
          recovery_phrase: 'another test recovery phrase'
        )
        expect(account).not_to be_valid
      end
    end
  end
end
