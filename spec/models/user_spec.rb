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
       expect(@user.valid?)
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

      it 'should error if email is already registerd in database can insensative' do
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

      xit '' do
      
      end

      xit '' do
      
      end

    end
  end
end
