require "csv"

class DashboardController < ApplicationController
  def index
    @clientes_count = Cliente.count
    @veiculos_count = Veiculo.count
    @ordens_count = OrdemServico.count
    @ordens_abertas_count = OrdemServico.abertas.count
    @faturamento_previsto = OrdemServico.sum(:valor)
    @ordens_recentes = OrdemServico.includes(veiculo: :cliente).recentes.limit(5)
  end

  def exportar_csv
    ordens = OrdemServico.includes(veiculo: :cliente).recentes

    csv = CSV.generate(headers: true) do |arquivo|
      arquivo << [ "id", "cliente", "veiculo", "status", "valor" ]

      ordens.each do |ordem|
        arquivo << [
          ordem.id,
          ordem.cliente.name,
          ordem.veiculo.nome_completo,
          ordem.status,
          format("%.2f", ordem.valor.to_f)
        ]
      end
    end

    send_data csv,
      filename: "oficina_ordens_#{Date.current.strftime('%Y%m%d')}.csv",
      type: "text/csv; charset=utf-8"
  end
end
