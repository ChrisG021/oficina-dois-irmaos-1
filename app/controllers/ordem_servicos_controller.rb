class OrdemServicosController < ApplicationController
  before_action :set_ordem_servico, only: %i[ show edit update destroy ]

  def index
    ordens = OrdemServico.includes(veiculo: :cliente).recentes
    ordens = ordens.where(status: params[:status]) if params[:status].present?

    respond_to do |format|
      format.html { @ordem_servicos = ordens.page(params[:page]).per(8) }
      format.json { @ordem_servicos = ordens }
      format.pdf do
        send_data ordens_pdf(ordens),
          filename: "ordens_servico_#{Date.current.strftime('%Y%m%d')}.pdf",
          type: "application/pdf",
          disposition: "attachment"
      end
    end
  end

  def show
  end

  def new
    @ordem_servico = OrdemServico.new(
      veiculo_id: params[:veiculo_id],
      data_entrada: Date.current,
      status: "Aberta"
    )
  end

  def edit
  end

  def create
    @ordem_servico = OrdemServico.new(ordem_servico_params)

    respond_to do |format|
      if @ordem_servico.save
        format.html { redirect_to @ordem_servico, notice: "Ordem de servico cadastrada com sucesso." }
        format.json { render :show, status: :created, location: @ordem_servico }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @ordem_servico.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @ordem_servico.update(ordem_servico_params)
        format.html { redirect_to @ordem_servico, notice: "Ordem de servico atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @ordem_servico }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @ordem_servico.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @ordem_servico.destroy!

    respond_to do |format|
      format.html { redirect_to ordem_servicos_path, notice: "Ordem de servico removida com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_ordem_servico
      @ordem_servico = OrdemServico.find(params.expect(:id))
    end

    def ordem_servico_params
      params.expect(ordem_servico: [ :veiculo_id, :descricao, :status, :valor, :data_entrada, :data_saida ])
    end

    def ordens_pdf(ordens)
      rows = ordens.map do |ordem|
        [
          ordem.id,
          ordem.cliente.name,
          ordem.veiculo.placa,
          ordem.status,
          format("R$ %.2f", ordem.valor.to_f)
        ]
      end
      ReportPdf.generate(title: "Relatorio de ordens de servico", headers: [ "ID", "Cliente", "Placa", "Status", "Valor" ], rows:)
    end
end
