# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'guest cant get show' do
    get profile_url
    assert_redirected_to root_url
  end

  test 'signed user get show' do
    user = users(:full)
    sign_in(user)
    get profile_url
    assert_response :success
  end
end
