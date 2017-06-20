require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "123456", password_confirmation: "123456")
  end

  test "should be vaild" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "   "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "   "
  	assert @user.invalid?
  end

  test "name should not be too long" do
  	@user.name = "a"*32
  	assert @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a"*38+"@example.com"
  	assert @user.valid?
  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[abc@gm-,ail.com]
    invalid_addresses.each do |x| 
      @user.email = x
      assert_not @user.valid?, "#{invalid_addresses.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    user2 = @user.dup
    user2.email.upcase!
    @user.save
    assert_not user2.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = "AbC@EddsaE.coM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "ABC")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
