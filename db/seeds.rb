admin = User.find_or_initialize_by(email: "admin@oficina.com")
admin.password = "123456"
admin.password_confirmation = "123456"
admin.save!

cliente_1 = Cliente.find_or_create_by!(email: "joao.silva@email.com") do |cliente|
  cliente.name = "Joao Silva"
  cliente.phone = "(86) 99999-1111"
end

cliente_2 = Cliente.find_or_create_by!(email: "maria.sousa@email.com") do |cliente|
  cliente.name = "Maria Sousa"
  cliente.phone = "(86) 98888-2222"
end

cliente_3 = Cliente.find_or_create_by!(email: "carlos.lima@email.com") do |cliente|
  cliente.name = "Carlos Lima"
  cliente.phone = "(86) 97777-3333"
end

veiculo_1 = Veiculo.find_or_create_by!(placa: "ABC-1234") do |veiculo|
  veiculo.cliente = cliente_1
  veiculo.marca = "Fiat"
  veiculo.modelo = "Uno"
  veiculo.ano = 2015
end

veiculo_2 = Veiculo.find_or_create_by!(placa: "PQR-8A21") do |veiculo|
  veiculo.cliente = cliente_2
  veiculo.marca = "Toyota"
  veiculo.modelo = "Corolla"
  veiculo.ano = 2020
end

veiculo_3 = Veiculo.find_or_create_by!(placa: "XYZ-4321") do |veiculo|
  veiculo.cliente = cliente_3
  veiculo.marca = "Honda"
  veiculo.modelo = "Civic"
  veiculo.ano = 2018
end

OrdemServico.find_or_create_by!(veiculo: veiculo_1, descricao: "Troca de oleo e revisao preventiva") do |ordem|
  ordem.status = "Concluida"
  ordem.valor = 280
  ordem.data_entrada = 5.days.ago.to_date
  ordem.data_saida = 4.days.ago.to_date
end

OrdemServico.find_or_create_by!(veiculo: veiculo_2, descricao: "Diagnostico de injecao eletronica") do |ordem|
  ordem.status = "Em andamento"
  ordem.valor = 450
  ordem.data_entrada = Date.current
end

OrdemServico.find_or_create_by!(veiculo: veiculo_3, descricao: "Substituicao das pastilhas de freio") do |ordem|
  ordem.status = "Aberta"
  ordem.valor = 360
  ordem.data_entrada = Date.current
end
