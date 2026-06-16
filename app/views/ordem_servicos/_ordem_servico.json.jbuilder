json.extract! ordem_servico, :id, :veiculo_id, :descricao, :status, :valor, :data_entrada, :data_saida, :created_at, :updated_at
json.url ordem_servico_url(ordem_servico, format: :json)
