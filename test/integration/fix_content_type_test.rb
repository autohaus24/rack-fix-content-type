require 'test_helper'

class FixContentTypeTest < ActionDispatch::IntegrationTest
  test "fix the content type" do
    file = fixture_file_upload(Rails.root.join("test/fixtures/shoulda_cheat_sheet.pdf"), "text/html")

    post '/fix_content_type', :document => file

    assert_equal "application/pdf", JSON.load(response.body)["document"]["content_type"]
  end

  test "fix the content type with nested params" do
    file = fixture_file_upload(Rails.root.join("test/fixtures/shoulda_cheat_sheet.pdf"), "text/html")

    post '/fix_content_type', :document => { :file => file }

    assert_equal "application/pdf", JSON.load(response.body)["document"]["file"]["content_type"]
  end

  test "detect csv files" do
    file = fixture_file_upload(Rails.root.join("test/fixtures/csv.csv"), "text/html")

    post '/fix_content_type', :document => file

    assert_equal "text/csv", JSON.load(response.body)["document"]["content_type"]
  end

  test "have no errors when the tempfile is no file" do
    post '/fix_content_type', :document => { :tempfile => "no_file" }
    assert_response :success
  end

  test "have no errors when there is no form data" do
    get '/fix_content_type'
    assert_response :success
  end

  test "work without upload" do
    post '/fix_content_type'
    assert_response :success
  end
end
