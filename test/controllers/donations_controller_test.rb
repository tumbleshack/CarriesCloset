require "test_helper"

class DonationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donation = donations(:one)
  end

  test "should get index" do
    get donations_url
    assert_response :success
  end

  test "should get new" do
    get new_donation_url
    assert_response :success
  end

  test "should create donation" do
    assert_difference('Donation.count') do

      post donations_url, params: { donation: { address: @donation.address, availability: @donation.availability, comments: @donation.comments, county: @donation.county, email: @donation.email, full_name: @donation.full_name, item_changes: @donation.item_changes, meet: @donation.meet, phone: @donation.phone } }

    end

    assert_redirected_to donation_url(Donation.last)
  end

  test "should show donation" do
    get donation_url(@donation)
    assert_response :success
  end

  test "should get edit" do
    get edit_donation_url(@donation)
    assert_response :success
  end

  test "should update donation" do

    patch donation_url(@donation), params: { donation: { address: @donation.address, availability: @donation.availability, comments: @donation.comments, county: @donation.county, email: @donation.email, full_name: @donation.full_name, item_changes: @donation.item_changes, meet: @donation.meet, phone: @donation.phone } }

    assert_redirected_to donation_url(@donation)
  end

  test "should destroy donation" do
    assert_difference('Donation.count', -1) do
      delete donation_url(@donation)
    end

    assert_redirected_to donations_url
  end
end
