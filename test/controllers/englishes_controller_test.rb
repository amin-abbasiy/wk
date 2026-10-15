require "test_helper"

class EnglishesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @english = englishes(:one)
  end

  test "should get index" do
    get englishes_url
    assert_response :success
  end

  test "should get new" do
    get new_english_url
    assert_response :success
  end

  test "should create english" do
    assert_difference("English.count") do
      post englishes_url, params: { english: {  } }
    end

    assert_redirected_to english_url(English.last)
  end

  test "should show english" do
    get english_url(@english)
    assert_response :success
  end

  test "should get edit" do
    get edit_english_url(@english)
    assert_response :success
  end

  test "should update english" do
    patch english_url(@english), params: { english: {  } }
    assert_redirected_to english_url(@english)
  end

  test "should destroy english" do
    assert_difference("English.count", -1) do
      delete english_url(@english)
    end

    assert_redirected_to englishes_url
  end
end
