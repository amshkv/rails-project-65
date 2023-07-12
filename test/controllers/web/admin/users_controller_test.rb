# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:full)
    sign_in(user)
    @editing_user = users(:not_admin)
  end

  test 'get index' do
    get admin_users_url
    assert_response :success
  end

  test 'get edit' do
    get edit_admin_user_url(@editing_user)
    assert_response :success
  end

  test 'update user' do
    patch admin_user_url(@editing_user), params: { user: { admin: true } }

    @editing_user.reload

    assert { @editing_user.admin? }
    assert_redirected_to admin_users_url
  end
end
