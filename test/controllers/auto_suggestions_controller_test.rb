require "test_helper"

class AutoSuggestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auto_suggestion = auto_suggestions(:one)
  end

  test "should get index" do
    get auto_suggestions_url
    assert_response :success
  end

  test "should get new" do
    get new_auto_suggestion_url
    assert_response :success
  end

  test "should create auto_suggestion" do
    assert_difference("AutoSuggestion.count") do
      post auto_suggestions_url, params: { auto_suggestion: { action: @auto_suggestion.action, faith: @auto_suggestion.faith, idea: @auto_suggestion.idea, persistence: @auto_suggestion.persistence, plan: @auto_suggestion.plan } }
    end

    assert_redirected_to auto_suggestion_url(AutoSuggestion.last)
  end

  test "should show auto_suggestion" do
    get auto_suggestion_url(@auto_suggestion)
    assert_response :success
  end

  test "should get edit" do
    get edit_auto_suggestion_url(@auto_suggestion)
    assert_response :success
  end

  test "should update auto_suggestion" do
    patch auto_suggestion_url(@auto_suggestion), params: { auto_suggestion: { action: @auto_suggestion.action, faith: @auto_suggestion.faith, idea: @auto_suggestion.idea, persistence: @auto_suggestion.persistence, plan: @auto_suggestion.plan } }
    assert_redirected_to auto_suggestion_url(@auto_suggestion)
  end

  test "should destroy auto_suggestion" do
    assert_difference("AutoSuggestion.count", -1) do
      delete auto_suggestion_url(@auto_suggestion)
    end

    assert_redirected_to auto_suggestions_url
  end
end
