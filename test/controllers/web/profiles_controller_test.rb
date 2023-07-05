# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'should guest cant get show' do
    get profile_path
    assert_response :redirect
  end

  test 'should signed user get show' do
    user = users(:full)
    sign_in(user)
    get profile_path
    assert_response :success
  end
end
