# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get show' do
    bulletin = bulletins(:one)

    get bulletin_url(bulletin)
    assert_response :success
  end
end
