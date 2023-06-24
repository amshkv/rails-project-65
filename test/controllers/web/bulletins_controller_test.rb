# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attrs = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      category_id: categories(:hobby).id,
      image: fixture_file_upload('deathly_hallows.png', 'image/png')
    }
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get show' do
    bulletin = bulletins(:one)

    get bulletin_url(bulletin)
    assert_response :success
  end

  test 'guest should raise error from new' do
    assert_raises(Pundit::NotAuthorizedError) do
      get new_bulletin_url
    end
  end

  test 'signed user should get new' do
    user = users(:full)
    sign_in(user)

    get new_bulletin_url
    assert_response :success
  end

  test 'guest cant create post' do
    assert_raises(Pundit::NotAuthorizedError) do
      post bulletins_url, params: { bulletin: @attrs }
    end

    bulletin = Bulletin.find_by(@attrs.except(:image))
    assert_not bulletin
  end

  test 'signed user can create post' do
    user = users(:full)
    sign_in(user)

    post bulletins_url, params: { bulletin: @attrs }
    bulletin = Bulletin.find_by(@attrs.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end
end
