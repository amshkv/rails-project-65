# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    user = users(:full)
    sign_in(user)
    get admin_bulletins_url
    assert_response :success
  end
end
