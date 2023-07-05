# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attrs = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      category_id: categories(:work).id,
      image: fixture_file_upload('deathly_hallows.png', 'image/png')
    }
    @bulletin = bulletins(:published)
    @user = users(:full)
  end

  test 'should get show' do
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should guest cant get new' do
    get new_bulletin_url
    assert_response :redirect
  end

  test 'should signed user get new' do
    sign_in(@user)

    get new_bulletin_url
    assert_response :success
  end

  test 'should guest cant get edit' do
    get edit_bulletin_url(@bulletin)
    assert_response :redirect
  end

  test 'should not_author bulletin cant get edit' do
    user = users(:without_bulletins)
    sign_in(user)
    get edit_bulletin_url(@bulletin)
    assert_response :redirect
  end

  test 'should author bulletin get edit' do
    sign_in(@user)
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should guest cant create bulletin' do
    post bulletins_url, params: { bulletin: @attrs }

    assert_response :redirect

    bulletin = Bulletin.find_by(@attrs.except(:image))
    assert_not bulletin
  end

  test 'should signed user can create bulletin' do
    sign_in(@user)

    post bulletins_url, params: { bulletin: @attrs }
    bulletin = Bulletin.find_by(@attrs.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end

  test 'should guest cant update bulletin' do
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert_response :redirect
  end

  test 'should not author cant update bulletin' do
    user = users(:without_bulletins)
    sign_in(user)
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert_response :redirect
  end

  test 'should signed user can update bulletin' do
    sign_in(@user)

    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title == @attrs[:title] }
    assert { @bulletin.description == @attrs[:description] }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test 'should send to moderate bulletin' do
    sign_in(@user)
    bulletin = bulletins(:draft)
    patch to_moderate_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.under_moderation? }
    assert_redirected_to profile_url
  end

  test 'should archive bulletin' do
    sign_in(@user)

    patch archive_bulletin_url(@bulletin)

    @bulletin.reload

    assert { @bulletin.archived? }
    assert_redirected_to profile_url
  end
end
