require "test_helper"

class EmailSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_setting = email_settings(:one)
  end

  test "should get index" do
    get email_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_email_setting_url
    assert_response :success
  end

  test "should create email_setting" do
    assert_difference('EmailSetting.count') do
      post email_settings_url, params: { email_setting: { preference: @email_setting.preference, user_id: @email_setting.user_id } }
    end

    assert_redirected_to email_setting_url(EmailSetting.last)
  end

  test "should show email_setting" do
    get email_setting_url(@email_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_setting_url(@email_setting)
    assert_response :success
  end

  test "should update email_setting" do
    patch email_setting_url(@email_setting), params: { email_setting: { preference: @email_setting.preference, user_id: @email_setting.user_id } }
    assert_redirected_to email_setting_url(@email_setting)
  end

  test "should destroy email_setting" do
    assert_difference('EmailSetting.count', -1) do
      delete email_setting_url(@email_setting)
    end

    assert_redirected_to email_settings_url
  end
end
