require "application_system_test_case"

class DonationsTest < ApplicationSystemTestCase
  setup do
    @donation = donations(:one)
  end

  test "visiting the index" do
    visit donations_url
    assert_selector "h1", text: "Donations"
  end

  test "creating a Donation" do
    visit donations_url
    click_on "New Donation"

    fill_in "Address", with: @donation.address
    fill_in "Availability", with: @donation.availability
    fill_in "Comments", with: @donation.comments
    fill_in "County", with: @donation.county
    fill_in "Email", with: @donation.email
    fill_in "Full name", with: @donation.full_name

    fill_in "Item Changes", with: @donation.item_changes

    check "Meet" if @donation.meet
    fill_in "Phone", with: @donation.phone
    click_on "Create Donation"

    assert_text "Donation was successfully created"
    click_on "Back"
  end

  test "updating a Donation" do
    visit donations_url
    click_on "Edit", match: :first

    fill_in "Address", with: @donation.address
    fill_in "Availability", with: @donation.availability
    fill_in "Comments", with: @donation.comments
    fill_in "County", with: @donation.county
    fill_in "Email", with: @donation.email
    fill_in "Full name", with: @donation.full_name

    fill_in "Item Changes", with: @donation.item_changes

    check "Meet" if @donation.meet
    fill_in "Phone", with: @donation.phone
    click_on "Update Donation"

    assert_text "Donation was successfully updated"
    click_on "Back"
  end

  test "destroying a Donation" do
    visit donations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Donation was successfully destroyed"
  end
end
