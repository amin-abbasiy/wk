require "application_system_test_case"

class EmailMessagesTest < ApplicationSystemTestCase
  setup do
    @email_message = email_messages(:one)
  end

  test "visiting the index" do
    visit email_messages_url
    assert_selector "h1", text: "Email messages"
  end

  test "should create email message" do
    visit email_messages_url
    click_on "New email message"

    fill_in "Message", with: @email_message.message
    fill_in "Response", with: @email_message.response
    click_on "Create Email message"

    assert_text "Email message was successfully created"
    click_on "Back"
  end

  test "should update Email message" do
    visit email_message_url(@email_message)
    click_on "Edit this email message", match: :first

    fill_in "Message", with: @email_message.message
    fill_in "Response", with: @email_message.response
    click_on "Update Email message"

    assert_text "Email message was successfully updated"
    click_on "Back"
  end

  test "should destroy Email message" do
    visit email_message_url(@email_message)
    click_on "Destroy this email message", match: :first

    assert_text "Email message was successfully destroyed"
  end
end
