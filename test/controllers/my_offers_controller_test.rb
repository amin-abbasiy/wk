require "test_helper"

class MyOffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_offer = my_offers(:one)
  end

  test "should get index" do
    get my_offers_url
    assert_response :success
  end

  test "should get new" do
    get new_my_offer_url
    assert_response :success
  end

  test "should create my_offer" do
    assert_difference("MyOffer.count") do
      post my_offers_url, params: { my_offer: { present: @my_offer.present, story: @my_offer.story, title: @my_offer.title } }
    end

    assert_redirected_to my_offer_url(MyOffer.last)
  end

  test "should show my_offer" do
    get my_offer_url(@my_offer)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_offer_url(@my_offer)
    assert_response :success
  end

  test "should update my_offer" do
    patch my_offer_url(@my_offer), params: { my_offer: { present: @my_offer.present, story: @my_offer.story, title: @my_offer.title } }
    assert_redirected_to my_offer_url(@my_offer)
  end

  test "should destroy my_offer" do
    assert_difference("MyOffer.count", -1) do
      delete my_offer_url(@my_offer)
    end

    assert_redirected_to my_offers_url
  end
end
