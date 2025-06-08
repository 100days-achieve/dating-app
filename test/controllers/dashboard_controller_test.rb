require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should redirect to login when not authenticated" do
    get dashboard_url
    assert_redirected_to new_session_path
  end

  test "should get dashboard when authenticated" do
    # セッションを設定してログイン状態をシミュレート
    sign_in_as(@user)

    get dashboard_url
    assert_response :success
  end

  test "should display welcome message on dashboard" do
    sign_in_as(@user)

    get dashboard_url
    assert_response :success
    assert_select "h2", text: /ダッシュボードへようこそ/i
  end

  test "should display main sections" do
    sign_in_as(@user)

    get dashboard_url
    assert_response :success

    # メインセクションの存在を確認
    assert_select ".bg-white.rounded-3xl", minimum: 3
    assert_select "h3", text: /新しいマッチ|おすすめユーザー|クイックアクション/
  end

  test "should display quick action buttons" do
    sign_in_as(@user)

    get dashboard_url
    assert_response :success

    # クイックアクションボタンの存在を確認
    assert_select "span", text: /プロフィール編集/i
    assert_select "span", text: /ユーザー検索/i
  end

  test "should display logout link" do
    sign_in_as(@user)

    get dashboard_url
    assert_response :success

    # ログアウトリンクの存在を確認
    assert_select "a[href='#{session_path}']", text: /ログアウト/i
  end

  test "should display header with app name" do
    sign_in_as(@user)

    get dashboard_url
    assert_response :success

    # ヘッダーにアプリ名が表示されることを確認
    assert_select "h1", text: /LoveConnect/i
  end

  test "should set return_to_after_authenticating when redirecting" do
    get dashboard_url
    assert_redirected_to new_session_path
    assert_equal dashboard_url, session[:return_to_after_authenticating]
  end
end
