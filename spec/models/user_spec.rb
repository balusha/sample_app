require 'rails_helper'

RSpec.describe User, type: :model do
  before {@user = User.new(name:'Ololoev Trololo', email:'ololoev@trololos.org',
                            password: 'foobar', password_confirmation: 'foobar')}

  subject {@user}

  it { should respond_to :name}
  it { should respond_to :email}
  it { should respond_to :password_digest}
  it { should respond_to :password}
  it { should respond_to :password_confirmation}
  it { should respond_to :authenticate}
  it { should respond_to :admin }
  it { should respond_to :microposts }

  it { should be_valid}
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle! :admin
    end

    it { should be_admin }

  end

  describe 'when name is not present' do
    before {@user.name = ' '}
    it {should_not be_valid}
  end

  describe 'when email isn`t present' do
    before {@user.email = ' '}
    it {should_not be_valid}
  end

  describe 'when password is not present' do
    before {@user.password = @user.password_confirmation = ''}
    it {should_not be_valid}
  end

  describe 'when name is too long' do
    before {@user.name = 'a'*51}
    it {should_not be_valid}
  end

  describe 'when password doesn`t match confirmation' do
    before {@user.password_confirmation = 'ololo'}
    it {should_not be_valid}
  end

  describe 'when email is invalid' do
    it "should be invalid" do
      adresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      adresses.each do |invalid_adress|
        @user.email = invalid_adress
        expect(@user).not_to be_valid
      end
    end

    describe 'when email is valid' do
      it "should be valid" do
        adresses = %w[user@foo.COM A_US-ER@f.b.org frst@foo.jp a+b@baz.cn]
        adresses.each do |valid_email|
          @user.email = valid_email
          expect(@user).to be_valid
        end
      end
    end
  end

  describe 'when email adress is already taken' do
    before do
      user_dup = @user.dup
      user_dup.email.upcase!
      user_dup.save
    end
    it {should_not be_valid}
  end

  describe 'return value of authenticate method' do
    before {@user.save}
    let(:found_user) {User.find_by(email: @user.email)}

    describe "with valid password" do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}

      it {should_not eq user_for_invalid_password}
      specify {expect(user_for_invalid_password).to be_falsey}

    end

    describe "with a password that`s too short" do
      before { @user.password = @user.password_confirmation = 'a'*5}
      it {should_not be_valid}
    end

  end

  describe "must have remember_token" do
    before {@user.save}
    #its (:remember_token){should_not be_blank}
    it {expect(@user.remember_token).not_to be_blank}
  end

end
