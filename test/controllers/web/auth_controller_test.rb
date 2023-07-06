# frozen_string_literal: true

require 'test_helper' # TODO: в теории (в примере) про это ничего нет, но в остальных тестах пишем?!
class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'check github auth' do
    post auth_request_path('github')
    assert_redirected_to callback_auth_url(:github)
  end

  test 'create' do
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        name: Faker::Name.first_name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
    assert_redirected_to root_url

    user = User.find_by!(email: auth_hash[:info][:email].downcase)

    assert { user }
    assert { signed_in? }
  end

  test 'logout' do
    user = users(:full)
    sign_in(user)

    delete auth_logout_url
    assert_redirected_to root_url

    assert { !signed_in? }
  end
end
