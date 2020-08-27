require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:juta_hachimaki)
    remember(@user)
  end

  test 'セッションがnilだった時にログインされる' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'digestが間違ってるときcurrent_userがnilを返す' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end

