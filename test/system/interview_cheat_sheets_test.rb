require "application_system_test_case"

class InterviewCheatSheetsTest < ApplicationSystemTestCase
  setup do
    @interview_cheat_sheet = interview_cheat_sheets(:one)
  end

  test "visiting the index" do
    visit interview_cheat_sheets_url
    assert_selector "h1", text: "Interview cheat sheets"
  end

  test "should create interview cheat sheet" do
    visit interview_cheat_sheets_url
    click_on "New interview cheat sheet"

    fill_in "Accomplishments skills", with: @interview_cheat_sheet.accomplishments_skills
    fill_in "Company", with: @interview_cheat_sheet.company
    fill_in "Company info", with: @interview_cheat_sheet.company_info
    fill_in "Date", with: @interview_cheat_sheet.date
    fill_in "Interviewers", with: @interview_cheat_sheet.interviewers
    fill_in "Location", with: @interview_cheat_sheet.location
    fill_in "My pitch", with: @interview_cheat_sheet.my_pitch
    fill_in "My questions", with: @interview_cheat_sheet.my_questions
    fill_in "Positon", with: @interview_cheat_sheet.positon
    fill_in "Predicted question answers", with: @interview_cheat_sheet.predicted_question_answers
    fill_in "Reason about position", with: @interview_cheat_sheet.reason_about_position
    click_on "Create Interview cheat sheet"

    assert_text "Interview cheat sheet was successfully created"
    click_on "Back"
  end

  test "should update Interview cheat sheet" do
    visit interview_cheat_sheet_url(@interview_cheat_sheet)
    click_on "Edit this interview cheat sheet", match: :first

    fill_in "Accomplishments skills", with: @interview_cheat_sheet.accomplishments_skills
    fill_in "Company", with: @interview_cheat_sheet.company
    fill_in "Company info", with: @interview_cheat_sheet.company_info
    fill_in "Date", with: @interview_cheat_sheet.date
    fill_in "Interviewers", with: @interview_cheat_sheet.interviewers
    fill_in "Location", with: @interview_cheat_sheet.location
    fill_in "My pitch", with: @interview_cheat_sheet.my_pitch
    fill_in "My questions", with: @interview_cheat_sheet.my_questions
    fill_in "Positon", with: @interview_cheat_sheet.positon
    fill_in "Predicted question answers", with: @interview_cheat_sheet.predicted_question_answers
    fill_in "Reason about position", with: @interview_cheat_sheet.reason_about_position
    click_on "Update Interview cheat sheet"

    assert_text "Interview cheat sheet was successfully updated"
    click_on "Back"
  end

  test "should destroy Interview cheat sheet" do
    visit interview_cheat_sheet_url(@interview_cheat_sheet)
    click_on "Destroy this interview cheat sheet", match: :first

    assert_text "Interview cheat sheet was successfully destroyed"
  end
end
