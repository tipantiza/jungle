
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validaitons" do 

    context "Passwords" do
      it "should save when :password and :password_confirmation are identical" do
        @user = User.new(
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
        expect(@user.valid?).to be true
      end

      it "should throw error when :password and :password_confirmation are different" do
        @user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'WrongPassword'
        )
        expect(@user.valid?).to be false
      end

      it "should throw error when not given :password value" do
        @user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password: nil, 
          password_confirmation: 'Password'
        )
        expect(@user.valid?).to be false
      end

      it "should throw error when not given :password_confirmation value" do
        @user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: nil
        )
       expect(@user.valid?).to be false
      end

      it "should error if password is smaller then 6" do
        @user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password:'lol', 
          password_confirmation: 'lol'
        )

        expect(@user.valid?).to be false
      end
    end

    context 'Emails' do

      it 'should error if email is already registered in database' do
        @a_user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
        @a_user.save
        @b_user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
        expect(@b_user.valid?).to be false
      end

      it 'should error if email is already registerd in database case insensative' do
        @a_user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.COM', 
          password:'password', 
          password_confirmation: 'password'
        )
        @a_user.save
        @b_user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          email: 'LANDONTIPANTIZA@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
        expect(@b_user.valid?).to be false
      end
    end

    context 'first, last name fields and email' do 
      it 'should fail if not given an email' do
        @user = User.new( 
          first_name: 'landon', 
          last_name: 'tipantiza', 
          password:'password', 
          password_confirmation: 'password'
        )
       expect(@user.valid?).to be false
      end

      it 'should fail if not given a first name' do
        @user = User.new(
          last_name: 'tipantiza', 
          email: 'landontipantiza@gmail.COM', 
          password:'password', 
          password_confirmation: 'password'
        )
       expect(@user.valid?).to be false
      end

      it 'should fail if not given a last name' do
        @user = User.new(
          last_name: 'tipantiza',
          email: 'landontipantiza@gmail.COM', 
          password:'password', 
          password_confirmation: 'password'
        )
        expect(@user.valid?).to be false
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return user when given correct password' do
      @user = User.create(
          first_name: 'landon',
          last_name: 'tipantiza',
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
      @a_user = User.authenticate_with_credentials("landontipantiza@gmail.com", 'password')
      expect(@a_user).to eql(@user)
    end

    it 'should return false when wrong password' do
      @user = User.create(
          first_name: 'landon',
          last_name: 'tipantiza',
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
      @a_user = User.authenticate_with_credentials("landontipantiza@gmail.com", 'wrong_password')
      expect(@a_user).to be false
    end
    it 'should return user when white space is in the email' do
      @user = User.create(
          first_name: 'landon',
          last_name: 'tipantiza',
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
      @a_user = User.authenticate_with_credentials("  landontipantiza@gmail.com  ", 'password')
      expect(@a_user).to eql(@user)
    end

    it 'should return user when wrong case is in the email' do
      @user = User.create(
          first_name: 'landon',
          last_name: 'tipantiza',
          email: 'landontipantiza@gmail.com', 
          password:'password', 
          password_confirmation: 'password'
        )
      @a_user = User.authenticate_with_credentials("landontipantiza@gmail.COM", 'password')
      expect(@a_user).to eql(@user)
    end
  end
end