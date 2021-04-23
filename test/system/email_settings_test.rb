require "application_system_test_case"

class EmailSettingsTest < ApplicationSystemTestCase
  setup do
    @email_setting = email_settings(:one)
  end

  test "visiting the index" do
    visit email_settings_url
    assert_selector "h1", text: "Email Settings"
  end

  test "creating a Email setting" do
    visit email_settings_url
    click_on "New Email Setting"

    fill_in "Preference", with: @email_setting.preference
    fill_in "User", with: @email_setting.user_id
    click_on "Create Email setting"

    assert_text "Email setting was successfully created"
    click_on "Back"
  end

  test "updating a Email setting" do
    visit email_settings_url
    click_on "Edit", match: :first

    fill_in "Preference", with: @email_setting.preference
    fill_in "User", with: @email_setting.user_id
    click_on "Update Email setting"

    assert_text "Email setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Email setting" do
    visit email_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Email setting was successfully destroyed"
  end
end
