# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:full)
    sign_in(user)

    @attrs = {
      name: Faker::Company.name
    }
  end
  test 'should get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should create category' do
    post admin_categories_url, params: { category: @attrs }

    category = Category.find_by(@attrs)

    assert { category }
    assert_redirected_to admin_categories_url
  end

  test 'should get edit category' do
    category = categories(:work)
    get edit_admin_category_url(category)
    assert_response :success
  end

  test 'should update category' do
    category = categories(:work)
    patch admin_category_url(category), params: { category: @attrs }

    updated_category = Category.find_by(@attrs)

    assert { updated_category }
    assert_redirected_to admin_categories_url
  end

  test 'should destroy category' do
    category = categories(:work)
    delete admin_category_url(category)

    assert { !Category.exists?(category.id) }
    assert_redirected_to admin_categories_url
  end
end
