require "application_system_test_case"

class AutoSuggestionsTest < ApplicationSystemTestCase
  setup do
    @auto_suggestion = auto_suggestions(:one)
  end

  test "visiting the index" do
    visit auto_suggestions_url
    assert_selector "h1", text: "Auto suggestions"
  end

  test "should create auto suggestion" do
    visit auto_suggestions_url
    click_on "New auto suggestion"

    fill_in "Action", with: @auto_suggestion.action
    fill_in "Faith", with: @auto_suggestion.faith
    fill_in "Idea", with: @auto_suggestion.idea
    fill_in "Persistence", with: @auto_suggestion.persistence
    fill_in "Plan", with: @auto_suggestion.plan
    click_on "Create Auto suggestion"

    assert_text "Auto suggestion was successfully created"
    click_on "Back"
  end

  test "should update Auto suggestion" do
    visit auto_suggestion_url(@auto_suggestion)
    click_on "Edit this auto suggestion", match: :first

    fill_in "Action", with: @auto_suggestion.action
    fill_in "Faith", with: @auto_suggestion.faith
    fill_in "Idea", with: @auto_suggestion.idea
    fill_in "Persistence", with: @auto_suggestion.persistence
    fill_in "Plan", with: @auto_suggestion.plan
    click_on "Update Auto suggestion"

    assert_text "Auto suggestion was successfully updated"
    click_on "Back"
  end

  test "should destroy Auto suggestion" do
    visit auto_suggestion_url(@auto_suggestion)
    click_on "Destroy this auto suggestion", match: :first

    assert_text "Auto suggestion was successfully destroyed"
  end
end
