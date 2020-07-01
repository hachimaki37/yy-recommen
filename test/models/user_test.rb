require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "yhoge", email: "yuta@email.com",
                    password: "foobarr", password_confirmation: "foobarr")
  end

  test "有効化どうかをテストする" do
    assert @user.valid?
  end

  test "name属性が無有効化かどうかをテストする" do
  @user.name = ""
  assert_not @user.valid?
  end

  test "email属性が無効化どうかをテストする" do
  @user.email = ""
  assert_not @user.valid?    
  end

  test "name属性の文字数を25を上限する" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email属性の文字数を255を上限にする" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "有効なemailが通ること" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid" #エラーメッセージ
    end
  end
  
  test "無効なemailを制御すること" do
    invalid_addresses = %w( user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com foo@bar..com )
    invalid_addresses.each do |invalid_addresse|
    @user.email = invalid_addresse
    assert_not @user.valid?, "#{invalid_addresse.inspect} should be valid" #エラーメッセージ
    end
  end

  test "emailの一意性を確認する" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "emailが小文字に変換されても保存される" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "emailが空にならないこと" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "emailが最小文字数にならないこと" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
