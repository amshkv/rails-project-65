# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:full)
    sign_in(user)
  end
  test 'should get index' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'should publish bulletin' do
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.published? }
    assert_redirected_to admin_root_url
  end

  test 'should cant publish bulletin with not under_moderation state' do
    bulletin = bulletins(:draft)
    patch publish_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.draft? }
    assert_redirected_to admin_root_url
  end

  test 'should reject bulletin' do
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.rejected? }
    assert_redirected_to admin_root_url
  end

  test 'should cant reject bulletin with not under_moderation state' do
    bulletin = bulletins(:draft)
    patch reject_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.draft? }
    assert_redirected_to admin_root_url
  end

  test 'should archive bulletin' do
    bulletin = bulletins(:published)
    patch archive_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.archived? }
    assert_redirected_to admin_bulletins_url
  end
end
