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
end
