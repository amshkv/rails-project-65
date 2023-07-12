# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:admin)
    sign_in(user)
  end
  test 'get index' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'publish bulletin' do
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.published? }
    assert_redirected_to admin_root_url
  end

  test 'cant publish bulletin with not under_moderation state' do
    bulletin = bulletins(:draft)
    patch publish_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.draft? }
    assert_redirected_to admin_root_url
  end

  test 'reject bulletin' do
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.rejected? }
    assert_redirected_to admin_root_url
  end

  test 'cant reject bulletin with not under_moderation state' do
    bulletin = bulletins(:draft)
    patch reject_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.draft? }
    assert_redirected_to admin_root_url
  end

  test 'archive bulletin' do
    bulletin = bulletins(:published)
    patch archive_admin_bulletin_url(bulletin)

    bulletin.reload

    assert { bulletin.archived? }
    assert_redirected_to admin_bulletins_url
  end
end
