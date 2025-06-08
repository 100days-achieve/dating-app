ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

# Integration test用の認証ヘルパー
module AuthenticationTestHelper
  def sign_in_as(user)
    # セッションを作成
    session = user.sessions.create!(
      user_agent: "Test Browser",
      ip_address: "127.0.0.1"
    )

    # Current.sessionを設定
    Current.session = session

    # 認証システムをモック
    ApplicationController.any_instance.stubs(:authenticated?).returns(true)
    ApplicationController.any_instance.stubs(:resume_session).returns(session)
    ApplicationController.any_instance.stubs(:find_session_by_cookie).returns(session)

    session
  end

  def sign_out
    Current.session = nil
    ApplicationController.any_instance.unstub(:authenticated?)
    ApplicationController.any_instance.unstub(:resume_session)
    ApplicationController.any_instance.unstub(:find_session_by_cookie)
  end

  def current_user
    Current.session&.user
  end
end

# Integration testでヘルパーを使用可能にする
class ActionDispatch::IntegrationTest
  include AuthenticationTestHelper

  # テスト前にCurrentをリセット
  setup do
    Current.session = nil
  end

  # テスト後にモックをクリア
  teardown do
    ApplicationController.any_instance.unstub(:authenticated?) rescue nil
    ApplicationController.any_instance.unstub(:resume_session) rescue nil
    ApplicationController.any_instance.unstub(:find_session_by_cookie) rescue nil
  end
end
