require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
  end

  test "visiting dashboard without login redirects to sign in" do
    visit dashboard_url

    assert_current_path new_session_path
    assert_text "Sign in"
  end

  test "visiting dashboard after login shows dashboard content" do
    # ログイン処理
    visit new_session_path
    fill_in "Email address", with: @user.email_address
    fill_in "Password", with: "password"
    click_on "Sign in"

    # ダッシュボードにリダイレクトされることを確認
    assert_current_path dashboard_path
    assert_text "ダッシュボード"
  end

  test "dashboard displays all required elements" do
    sign_in_user(@user)
    visit dashboard_url

    # メインタイトルの確認
    assert_text "ダッシュボード"

    # 統計カードの確認
    assert_text "マッチ数"
    assert_text "メッセージ数"
    assert_text "プロフィール閲覧数"
    assert_text "マッチング率"

    # クイックアクションの確認
    assert_text "プロフィール編集"
    assert_text "ユーザー検索"

    # ログアウトボタンの確認
    assert_button "ログアウト"
  end

  test "logout functionality works correctly" do
    sign_in_user(@user)
    visit dashboard_url

    # ログアウトボタンをクリック
    click_on "ログアウト"

    # ホームページにリダイレクトされることを確認
    assert_current_path root_path

    # 再度ダッシュボードにアクセスするとログインページにリダイレクト
    visit dashboard_url
    assert_current_path new_session_path
  end

  test "dashboard is responsive on mobile" do
    sign_in_user(@user)

    # モバイルサイズに変更
    page.driver.browser.manage.window.resize_to(375, 667)

    visit dashboard_url

    # モバイルでも基本要素が表示されることを確認
    assert_text "ダッシュボード"
    assert_text "マッチ数"
    assert_button "ログアウト"
  end

  test "dashboard statistics show correct format" do
    sign_in_user(@user)
    visit dashboard_url

    # 統計の数値が表示されていることを確認
    within(".bg-white.rounded-lg.shadow", match: :first) do
      assert_text /\d+/ # 数字が含まれていることを確認
    end
  end

  test "quick action buttons are clickable" do
    sign_in_user(@user)
    visit dashboard_url

    # プロフィール編集ボタンがクリック可能であることを確認
    profile_link = find("a", text: /プロフィール編集/i)
    assert profile_link[:href].present?

    # ユーザー検索ボタンがクリック可能であることを確認
    search_link = find("a", text: /ユーザー検索/i)
    assert search_link[:href].present?
  end

  private

  def sign_in_user(user)
    # システムテスト用のログイン処理
    visit new_session_path
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: "password"
    click_on "Sign in"
  end
end
