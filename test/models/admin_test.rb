require 'test_helper'

#
class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(last_name: 'Bond', first_name: 'James',
      email: '007@example.com', password: 'bond_james_bond',
      password_confirmation: 'bond_james_bond',
      confirmed_at: Time.now)
  end

  test 'should be valid' do
    assert @admin.valid?
  end

  test 'email should be present' do
    @admin.email = '     '
    assert_not @admin.valid?
  end

  test 'email should not be too long' do
    @admin.email = 'a' * 244 + '@example.com'
    assert_not @admin.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w(admin@example.com ADMIN@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @admin.email = valid_address
      assert @admin.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w(admin@example,com admin_at_foo.org
                           admin.name@example. foo@bar_baz.com
                           foo@bar+baz.com)
    invalid_addresses.each do |invalid_address|
      @admin.email = invalid_address
      assert_not @admin.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_admin = @admin.dup
    duplicate_admin.email = @admin.email.upcase
    @admin.save
    assert_not duplicate_admin.valid?
  end

  test 'first name should be present' do
    @admin.first_name = '     '
    @admin.last_name = 'Bond'
    assert_not @admin.valid?
  end

  test 'last name should be present' do
    @admin.first_name = 'James'
    @admin.last_name = '     '
    assert_not @admin.valid?
  end

  test 'first name should not be too long' do
    @admin.first_name = 'a' * 51
    @admin.last_name = 'Bond'
    assert_not @admin.valid?
  end

  test 'last name should not be too long' do
    @admin.first_name = 'James'
    @admin.last_name = 'a' * 51
    assert_not @admin.valid?
  end

  test 'password should have a minimum length' do
    @admin.password = @admin.password_confirmation = 'a' * 7
    assert_not @admin.valid?
  end
end
