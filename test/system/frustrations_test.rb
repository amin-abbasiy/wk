require "application_system_test_case"

class FrustrationsTest < ApplicationSystemTestCase
  setup do
    @frustration = frustrations(:one)
  end

  test "visiting the index" do
    visit frustrations_url
    assert_selector "h1", text: "Frustrations"
  end

  test "should create frustration" do
    visit frustrations_url
    click_on "New frustration"

    fill_in "Action plan", with: @frustration.action_plan
    fill_in "Catchphrase", with: @frustration.catchphrase
    fill_in "Channeling techniques", with: @frustration.channeling_techniques
    fill_in "Content", with: @frustration.content
    fill_in "Created purposes", with: @frustration.created_purposes
    fill_in "Emotions after action", with: @frustration.emotions_after_action
    fill_in "Goals for purposes", with: @frustration.goals_for_purposes
    fill_in "Reasons", with: @frustration.reasons
    fill_in "Resule of action", with: @frustration.resule_of_action
    fill_in "Result of emotions", with: @frustration.result_of_emotions
    fill_in "Title", with: @frustration.title
    fill_in "Trash them", with: @frustration.trash_them
    click_on "Create Frustration"

    assert_text "Frustration was successfully created"
    click_on "Back"
  end

  test "should update Frustration" do
    visit frustration_url(@frustration)
    click_on "Edit this frustration", match: :first

    fill_in "Action plan", with: @frustration.action_plan
    fill_in "Catchphrase", with: @frustration.catchphrase
    fill_in "Channeling techniques", with: @frustration.channeling_techniques
    fill_in "Content", with: @frustration.content
    fill_in "Created purposes", with: @frustration.created_purposes
    fill_in "Emotions after action", with: @frustration.emotions_after_action
    fill_in "Goals for purposes", with: @frustration.goals_for_purposes
    fill_in "Reasons", with: @frustration.reasons
    fill_in "Resule of action", with: @frustration.resule_of_action
    fill_in "Result of emotions", with: @frustration.result_of_emotions
    fill_in "Title", with: @frustration.title
    fill_in "Trash them", with: @frustration.trash_them
    click_on "Update Frustration"

    assert_text "Frustration was successfully updated"
    click_on "Back"
  end

  test "should destroy Frustration" do
    visit frustration_url(@frustration)
    click_on "Destroy this frustration", match: :first

    assert_text "Frustration was successfully destroyed"
  end
end
