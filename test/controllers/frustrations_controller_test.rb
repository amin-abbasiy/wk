require "test_helper"

class FrustrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @frustration = frustrations(:one)
  end

  test "should get index" do
    get frustrations_url
    assert_response :success
  end

  test "should get new" do
    get new_frustration_url
    assert_response :success
  end

  test "should create frustration" do
    assert_difference("Frustration.count") do
      post frustrations_url, params: { frustration: { action_plan: @frustration.action_plan, catchphrase: @frustration.catchphrase, channeling_techniques: @frustration.channeling_techniques, content: @frustration.content, created_purposes: @frustration.created_purposes, emotions_after_action: @frustration.emotions_after_action, goals_for_purposes: @frustration.goals_for_purposes, reasons: @frustration.reasons, resule_of_action: @frustration.resule_of_action, result_of_emotions: @frustration.result_of_emotions, title: @frustration.title, trash_them: @frustration.trash_them } }
    end

    assert_redirected_to frustration_url(Frustration.last)
  end

  test "should show frustration" do
    get frustration_url(@frustration)
    assert_response :success
  end

  test "should get edit" do
    get edit_frustration_url(@frustration)
    assert_response :success
  end

  test "should update frustration" do
    patch frustration_url(@frustration), params: { frustration: { action_plan: @frustration.action_plan, catchphrase: @frustration.catchphrase, channeling_techniques: @frustration.channeling_techniques, content: @frustration.content, created_purposes: @frustration.created_purposes, emotions_after_action: @frustration.emotions_after_action, goals_for_purposes: @frustration.goals_for_purposes, reasons: @frustration.reasons, resule_of_action: @frustration.resule_of_action, result_of_emotions: @frustration.result_of_emotions, title: @frustration.title, trash_them: @frustration.trash_them } }
    assert_redirected_to frustration_url(@frustration)
  end

  test "should destroy frustration" do
    assert_difference("Frustration.count", -1) do
      delete frustration_url(@frustration)
    end

    assert_redirected_to frustrations_url
  end
end
