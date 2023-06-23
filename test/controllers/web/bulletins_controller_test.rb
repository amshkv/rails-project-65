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

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    user = users(:full)
    sign_in(user)

    params = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      category_id: categories(:hobby).id,
      image: fixture_file_upload('deathly_hallows.png', 'image/png')
    }

    post bulletins_url, params: { bulletin: params }
    bulletin = Bulletin.find_by(params.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end
end
