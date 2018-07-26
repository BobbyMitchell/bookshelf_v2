require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get resouces" do
    get books_resouces_url
    assert_response :success
  end

end
