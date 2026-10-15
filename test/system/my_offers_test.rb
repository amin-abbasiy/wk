require "application_system_test_case"

class MyOffersTest < ApplicationSystemTestCase
  setup do
    @my_offer = my_offers(:one)
  end

  test "visiting the index" do
    visit my_offers_url
    assert_selector "h1", text: "My offers"
  end

  test "should create my offer" do
    visit my_offers_url
    click_on "New my offer"

    fill_in "Present", with: @my_offer.present
    fill_in "Story", with: @my_offer.story
    fill_in "Title", with: @my_offer.title
    click_on "Create My offer"

    assert_text "My offer was successfully created"
    click_on "Back"
  end

  test "should update My offer" do
    visit my_offer_url(@my_offer)
    click_on "Edit this my offer", match: :first

    fill_in "Present", with: @my_offer.present
    fill_in "Story", with: @my_offer.story
    fill_in "Title", with: @my_offer.title
    click_on "Update My offer"

    assert_text "My offer was successfully updated"
    click_on "Back"
  end

  test "should destroy My offer" do
    visit my_offer_url(@my_offer)
    click_on "Destroy this my offer", match: :first

    assert_text "My offer was successfully destroyed"
  end
end
