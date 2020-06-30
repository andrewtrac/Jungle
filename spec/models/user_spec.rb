require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before do
      @testuser = User.new(first_name: "JJ", last_name: "Lasky", email: "jjl@gmail.com", password: "abc123", password_confirmation: "abc123")
      @testuser.save
    end
      
    it 'creates new user' do
      @user = User.new(first_name: "Andy", last_name: "Johnson", email: "aj@gmail.com", password: "abc123", password_confirmation: "abc123")
      expect(@user).to be_valid
    end

    it 'should not create user if password is not present' do
      @user = User.new(first_name: "Andy", last_name: "Johnson", email: "aj@gmail.com", password: nil, password_confirmation: nil)
      expect(@user).not_to be_valid
    end

    it "should not create user if passwords don't match" do
      @user = User.new(first_name: "Andy", last_name: "Johnson", email: "aj@gmail.com", password: 'password', password_confirmation: 'password123')
      expect(@user).not_to be_valid
    end

    it "should not create user if email already exists" do
      @user = User.new(first_name: "Andy", last_name: "Johnson", email: "jJl@gmail.com", password: 'password', password_confirmation: 'password')
      expect(@user).not_to be_valid
    end

    it "should not create user if email does not exist" do
      @user = User.new(first_name: "Andy", last_name: "Johnson", email: nil, password: 'password', password_confirmation: 'password')
      expect(@user).not_to be_valid
    end

    it "should not create user if first name does not exist" do
      @user = User.new(first_name: nil, last_name: "Johnson", email: 'jat@gmail.com', password: 'password', password_confirmation: 'password')
      expect(@user).not_to be_valid
    end

    it "should not create user if last name does not exist" do
      @user = User.new(first_name: 'Andy', last_name: nil, email: 'jat@gmail.com', password: 'password', password_confirmation: 'password')
      expect(@user).not_to be_valid
    end

    it 'should not create password if password is not a minimum of length of 3 characters' do
      @user = User.new(first_name: 'Andy', last_name: 'Jackson  ', email: 'jat@gmail.com', password: 'ab', password_confirmation: 'ab')
      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    before do
      @testuser = User.new(first_name: "JJ", last_name: "Lasky", email: "jjl@gmail.com", password: "abc123", password_confirmation: "abc123")
      @testuser.save
    end

    it 'should detect the method' do
      expect(User.authenticate_with_credentials('jjl@gmail.com', 'abc123')).to be
    end 

    it 'should return the user with email' do
       @existing_user = (User.authenticate_with_credentials('jjl@gmail.com', 'abc123'))
      expect(@existing_user.email).to eql('jjl@gmail.com')
    end

    it 'should not return the user if password is incorrect' do
      @existing_user = (User.authenticate_with_credentials('jjl@gmail.com', '123'))
      expect(@existing_user).to eql(nil)
   end
    
    it 'should return the user if password is correct' do
      @existing_user = (User.authenticate_with_credentials('jjl@gmail.com', 'abc123'))
      expect(@existing_user.email).to eql('jjl@gmail.com')
    end

    it 'should log user in if email has spaces before first character' do
      @existing_user = (User.authenticate_with_credentials('  jjl@gmail.com', 'abc123'))
      expect(@existing_user.email).to eql('jjl@gmail.com')
    end

    it 'should log user in even if email cases do not match' do
      @existing_user = (User.authenticate_with_credentials('Jjl@gmail.com', 'abc123'))
      expect(@existing_user.email).to eql('jjl@gmail.com')
    end
  end
end

#      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
