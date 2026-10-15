require "test_helper"

class ShiftShamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_shame = shift_shames(:one)
  end

  test "should get index" do
    get shift_shames_url
    assert_response :success
  end

  test "should get new" do
    get new_shift_shame_url
    assert_response :success
  end

  test "should create shift_shame" do
    assert_difference("ShiftShame.count") do
      post shift_shames_url, params: { shift_shame: { emotion_behind_shame: @shift_shame.emotion_behind_shame, realign_with_values: @shift_shame.realign_with_values, seperate_people_story: @shift_shame.seperate_people_story, shift_to_appriciaton: @shift_shame.shift_to_appriciaton, uncover_emotion_root: @shift_shame.uncover_emotion_root } }
    end

    assert_redirected_to shift_shame_url(ShiftShame.last)
  end

  test "should show shift_shame" do
    get shift_shame_url(@shift_shame)
    assert_response :success
  end

  test "should get edit" do
    get edit_shift_shame_url(@shift_shame)
    assert_response :success
  end

  test "should update shift_shame" do
    patch shift_shame_url(@shift_shame), params: { shift_shame: { emotion_behind_shame: @shift_shame.emotion_behind_shame, realign_with_values: @shift_shame.realign_with_values, seperate_people_story: @shift_shame.seperate_people_story, shift_to_appriciaton: @shift_shame.shift_to_appriciaton, uncover_emotion_root: @shift_shame.uncover_emotion_root } }
    assert_redirected_to shift_shame_url(@shift_shame)
  end

  test "should destroy shift_shame" do
    assert_difference("ShiftShame.count", -1) do
      delete shift_shame_url(@shift_shame)
    end

    assert_redirected_to shift_shames_url
  end
end
