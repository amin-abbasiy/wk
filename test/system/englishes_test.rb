require "application_system_test_case"

class EnglishesTest < ApplicationSystemTestCase
  setup do
    @english = englishes(:one)
  end

  test "visiting the index" do
    visit englishes_url
    assert_selector "h1", text: "Englishes"
  end

  test "should create english" do
    visit englishes_url
    click_on "New english"

    click_on "Create English"

    assert_text "English was successfully created"
    click_on "Back"
  end

  test "should update English" do
    visit english_url(@english)
    click_on "Edit this english", match: :first

    click_on "Update English"

    assert_text "English was successfully updated"
    click_on "Back"
  end

  test "should destroy English" do
    visit english_url(@english)
    click_on "Destroy this english", match: :first

    assert_text "English was successfully destroyed"
  end
end
