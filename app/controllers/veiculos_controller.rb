class VeiculosController < ApplicationController
  before_action :set_veiculo, only: %i[ show edit update destroy ]

  def index
    veiculos = Veiculo.includes(:cliente).order(:marca, :modelo)

    respond_to do |format|
      format.html { @veiculos = veiculos.page(params[:page]).per(8) }
      format.json { @veiculos = veiculos }
      format.pdf do
        send_data veiculos_pdf(veiculos),
          filename: "veiculos_#{Date.current.strftime('%Y%m%d')}.pdf",
          type: "application/pdf",
          disposition: "attachment"
      end
    end
  end

  def show
    @ordens = @veiculo.ordem_servicos.recentes
  end

  def new
    @veiculo = Veiculo.new(cliente_id: params[:cliente_id])
  end

  def edit
  end

  def create
    @veiculo = Veiculo.new(veiculo_params)

    respond_to do |format|
      if @veiculo.save
        format.html { redirect_to @veiculo, notice: "Veiculo cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @veiculo }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @veiculo.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @veiculo.update(veiculo_params)
        format.html { redirect_to @veiculo, notice: "Veiculo atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @veiculo }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @veiculo.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @veiculo.destroy!

    respond_to do |format|
      format.html { redirect_to veiculos_path, notice: "Veiculo removido com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_veiculo
      @veiculo = Veiculo.find(params.expect(:id))
    end

    def veiculo_params
      params.expect(veiculo: [ :placa, :marca, :modelo, :ano, :cliente_id ])
    end

    def veiculos_pdf(veiculos)
      rows = veiculos.map do |veiculo|
        [ veiculo.id, veiculo.placa, "#{veiculo.marca} #{veiculo.modelo}", veiculo.cliente.name ]
      end
      ReportPdf.generate(title: "Relatorio de veiculos", headers: [ "ID", "Placa", "Veiculo", "Cliente" ], rows:)
    end
end
