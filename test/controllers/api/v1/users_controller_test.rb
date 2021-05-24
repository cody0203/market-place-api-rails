require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should show user' do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    json_resposne = JSON.parse(response.body)
    assert_equal @user.email, json_resposne['email']
  end

  test 'should create user' do
    assert_difference('User.count', 1) do
      post api_v1_users_url, params: { user: { email: 'user2@gmail.com', password: 'password' } }, as: :json
    end
    assert_response :created
  end

  test 'should not create user with taken email' do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: @user.email, password: 'password' } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test 'should update user' do
    patch api_v1_user_url(@user), params: { user: { email: @user.email, password: '123456' } }, as: :json
    assert_response :success
  end

  test 'should not update user when invalid params are sent' do
    patch api_v1_user_url(@user), params: { user: { email: 'bad email', password: '123456' } }, as: :json
    assert_response :unprocessable_entity
  end
end
