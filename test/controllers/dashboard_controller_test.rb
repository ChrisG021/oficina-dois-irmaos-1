require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get root_url
    assert_response :success
    assert_select "h1", "Resumo da oficina"
  end

  test "should export csv" do
    get dashboard_csv_url(format: :csv)
    assert_response :success
    assert_equal "text/csv", response.media_type
    assert_includes response.body, "id,cliente,veiculo,status,valor"
  end
end
