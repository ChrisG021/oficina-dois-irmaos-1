require "test_helper"

class VeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @veiculo = veiculos(:one)
  end

  test "should get index" do
    get veiculos_url
    assert_response :success
  end

  test "should export pdf" do
    get veiculos_url(format: :pdf)
    assert_response :success
    assert_equal "application/pdf", response.media_type
  end

  test "should get new" do
    get new_veiculo_url
    assert_response :success
  end

  test "should create veiculo" do
    assert_difference("Veiculo.count") do
      post veiculos_url, params: { veiculo: { ano: 2021, cliente_id: @veiculo.cliente_id, marca: "Toyota", modelo: "Hilux", placa: "HIL-2021" } }
    end

    assert_redirected_to veiculo_url(Veiculo.last)
  end

  test "should show veiculo" do
    get veiculo_url(@veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_veiculo_url(@veiculo)
    assert_response :success
  end

  test "should update veiculo" do
    patch veiculo_url(@veiculo), params: { veiculo: { ano: @veiculo.ano, cliente_id: @veiculo.cliente_id, marca: "Fiat", modelo: "Uno Mille", placa: @veiculo.placa } }
    assert_redirected_to veiculo_url(@veiculo)
  end

  test "should destroy veiculo" do
    assert_difference("Veiculo.count", -1) do
      delete veiculo_url(@veiculo)
    end

    assert_redirected_to veiculos_url
  end
end
