require "test_helper"

class InterviewCheatSheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interview_cheat_sheet = interview_cheat_sheets(:one)
  end

  test "should get index" do
    get interview_cheat_sheets_url
    assert_response :success
  end

  test "should get new" do
    get new_interview_cheat_sheet_url
    assert_response :success
  end

  test "should create interview_cheat_sheet" do
    assert_difference("InterviewCheatSheet.count") do
      post interview_cheat_sheets_url, params: { interview_cheat_sheet: { accomplishments_skills: @interview_cheat_sheet.accomplishments_skills, company: @interview_cheat_sheet.company, company_info: @interview_cheat_sheet.company_info, date: @interview_cheat_sheet.date, interviewers: @interview_cheat_sheet.interviewers, location: @interview_cheat_sheet.location, my_pitch: @interview_cheat_sheet.my_pitch, my_questions: @interview_cheat_sheet.my_questions, positon: @interview_cheat_sheet.positon, predicted_question_answers: @interview_cheat_sheet.predicted_question_answers, reason_about_position: @interview_cheat_sheet.reason_about_position } }
    end

    assert_redirected_to interview_cheat_sheet_url(InterviewCheatSheet.last)
  end

  test "should show interview_cheat_sheet" do
    get interview_cheat_sheet_url(@interview_cheat_sheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_interview_cheat_sheet_url(@interview_cheat_sheet)
    assert_response :success
  end

  test "should update interview_cheat_sheet" do
    patch interview_cheat_sheet_url(@interview_cheat_sheet), params: { interview_cheat_sheet: { accomplishments_skills: @interview_cheat_sheet.accomplishments_skills, company: @interview_cheat_sheet.company, company_info: @interview_cheat_sheet.company_info, date: @interview_cheat_sheet.date, interviewers: @interview_cheat_sheet.interviewers, location: @interview_cheat_sheet.location, my_pitch: @interview_cheat_sheet.my_pitch, my_questions: @interview_cheat_sheet.my_questions, positon: @interview_cheat_sheet.positon, predicted_question_answers: @interview_cheat_sheet.predicted_question_answers, reason_about_position: @interview_cheat_sheet.reason_about_position } }
    assert_redirected_to interview_cheat_sheet_url(@interview_cheat_sheet)
  end

  test "should destroy interview_cheat_sheet" do
    assert_difference("InterviewCheatSheet.count", -1) do
      delete interview_cheat_sheet_url(@interview_cheat_sheet)
    end

    assert_redirected_to interview_cheat_sheets_url
  end
end
