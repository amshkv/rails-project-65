# frozen_string_literal: true

require 'test_helper'

class Web::Admin::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'guest should raise error from admin' do
    get admin_root_path
    assert_response :redirect
  end

  test 'signed user should get admin' do
    user = users(:full)
    sign_in(user)

    get admin_root_path
    assert_response :success
  end
end
