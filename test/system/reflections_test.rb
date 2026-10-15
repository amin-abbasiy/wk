require "application_system_test_case"

class ReflectionsTest < ApplicationSystemTestCase
  setup do
    @reflection = reflections(:one)
  end

  test "visiting the index" do
    visit reflections_url
    assert_selector "h1", text: "Reflections"
  end

  test "should create reflection" do
    visit reflections_url
    click_on "New reflection"

    fill_in "Action", with: @reflection.action
    fill_in "Content", with: @reflection.content
    fill_in "Type", with: @reflection.type
    click_on "Create Reflection"

    assert_text "Reflection was successfully created"
    click_on "Back"
  end

  test "should update Reflection" do
    visit reflection_url(@reflection)
    click_on "Edit this reflection", match: :first

    fill_in "Action", with: @reflection.action
    fill_in "Content", with: @reflection.content
    fill_in "Type", with: @reflection.type
    click_on "Update Reflection"

    assert_text "Reflection was successfully updated"
    click_on "Back"
  end

  test "should destroy Reflection" do
    visit reflection_url(@reflection)
    click_on "Destroy this reflection", match: :first

    assert_text "Reflection was successfully destroyed"
  end
end
