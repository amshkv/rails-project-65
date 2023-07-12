# frozen_string_literal: true

require 'test_helper'

class Web::Admin::WelcomeControllerTest < ActionDispatch::IntegrationTest
  # NOTE: Тест, который проверяет, что гость не может получить доступ к страницам админки
  # Жизнь слишком коротка для того, чтобы проверять это в каждом контроллере
  test 'guest cant get admin page' do
    get admin_root_url
    assert_redirected_to root_url
  end

  test 'not admin cant get admin page' do
    user = users(:not_admin)
    sign_in(user)

    get admin_root_url
    assert_redirected_to root_url
  end

  test 'admin signed user get admin page' do
    user = users(:full)
    sign_in(user)

    get admin_root_url
    assert_response :success
  end
end
