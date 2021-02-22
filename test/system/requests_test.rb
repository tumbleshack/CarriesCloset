require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
  setup do
    @request = requests(:one)
  end

  test "visiting the index" do
    visit requests_url
    assert_selector "h1", text: "Requests"
  end

  test "creating a Request" do
    visit requests_url
    click_on "New Request"

    fill_in "Availability", with: @request.availability
    fill_in "Comments", with: @request.comments
    fill_in "County", with: @request.county
    fill_in "Email", with: @request.email
    fill_in "Full name", with: @request.full_name
    check "Meet" if @request.meet
    fill_in "Phone", with: @request.phone
    fill_in "Type", with: @request.type
    fill_in "Urgency", with: @request.urgency
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "updating a Request" do
    visit requests_url
    click_on "Edit", match: :first

    fill_in "Availability", with: @request.availability
    fill_in "Comments", with: @request.comments
    fill_in "County", with: @request.county
    fill_in "Email", with: @request.email
    fill_in "Full name", with: @request.full_name
    check "Meet" if @request.meet
    fill_in "Phone", with: @request.phone
    fill_in "Type", with: @request.type
    fill_in "Urgency", with: @request.urgency
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "destroying a Request" do
    visit requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request was successfully destroyed"
  end
end
