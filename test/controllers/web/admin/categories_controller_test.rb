# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:admin)
    sign_in(user)

    @attrs = {
      name: Faker::Beer.brand
    }
  end
  test 'get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'create category' do
    post admin_categories_url, params: { category: @attrs }

    category = Category.find_by(@attrs)

    assert { category }
    assert_redirected_to admin_categories_url
  end

  test 'get edit category' do
    category = categories(:work)
    get edit_admin_category_url(category)
    assert_response :success
  end

  test 'update category' do
    category = categories(:work)
    patch admin_category_url(category), params: { category: @attrs }

    category.reload

    assert { category.name == @attrs[:name] }
    assert_redirected_to admin_categories_url
  end

  test 'cant destroy non empty category' do
    category = categories(:work)
    delete admin_category_url(category)

    assert { Category.exists?(category.id) }
    assert_redirected_to admin_categories_url
  end

  test 'destroy empty category' do
    category = categories(:empty_category)
    delete admin_category_url(category)

    assert { !Category.exists?(category.id) }
    assert_redirected_to admin_categories_url
  end
end
