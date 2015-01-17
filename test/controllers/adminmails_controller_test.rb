require 'test_helper'

class AdminmailsControllerTest < ActionController::TestCase
  setup do
    @adminmail = adminmails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adminmails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adminmail" do
    assert_difference('Adminmail.count') do
      post :create, adminmail: { admin_mail: @adminmail.admin_mail }
    end

    assert_redirected_to adminmail_path(assigns(:adminmail))
  end

  test "should show adminmail" do
    get :show, id: @adminmail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adminmail
    assert_response :success
  end

  test "should update adminmail" do
    patch :update, id: @adminmail, adminmail: { admin_mail: @adminmail.admin_mail }
    assert_redirected_to adminmail_path(assigns(:adminmail))
  end

  test "should destroy adminmail" do
    assert_difference('Adminmail.count', -1) do
      delete :destroy, id: @adminmail
    end

    assert_redirected_to adminmails_path
  end
end
