require "application_system_test_case"

class ShiftShamesTest < ApplicationSystemTestCase
  setup do
    @shift_shame = shift_shames(:one)
  end

  test "visiting the index" do
    visit shift_shames_url
    assert_selector "h1", text: "Shift shames"
  end

  test "should create shift shame" do
    visit shift_shames_url
    click_on "New shift shame"

    fill_in "Emotion behind shame", with: @shift_shame.emotion_behind_shame
    fill_in "Realign with values", with: @shift_shame.realign_with_values
    fill_in "Seperate people story", with: @shift_shame.seperate_people_story
    fill_in "Shift to appriciaton", with: @shift_shame.shift_to_appriciaton
    fill_in "Uncover emotion root", with: @shift_shame.uncover_emotion_root
    click_on "Create Shift shame"

    assert_text "Shift shame was successfully created"
    click_on "Back"
  end

  test "should update Shift shame" do
    visit shift_shame_url(@shift_shame)
    click_on "Edit this shift shame", match: :first

    fill_in "Emotion behind shame", with: @shift_shame.emotion_behind_shame
    fill_in "Realign with values", with: @shift_shame.realign_with_values
    fill_in "Seperate people story", with: @shift_shame.seperate_people_story
    fill_in "Shift to appriciaton", with: @shift_shame.shift_to_appriciaton
    fill_in "Uncover emotion root", with: @shift_shame.uncover_emotion_root
    click_on "Update Shift shame"

    assert_text "Shift shame was successfully updated"
    click_on "Back"
  end

  test "should destroy Shift shame" do
    visit shift_shame_url(@shift_shame)
    click_on "Destroy this shift shame", match: :first

    assert_text "Shift shame was successfully destroyed"
  end
end
