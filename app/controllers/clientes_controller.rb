class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show edit update destroy ]

  def index
    clientes = Cliente.includes(:veiculos).order(:name)

    respond_to do |format|
      format.html { @clientes = clientes.page(params[:page]).per(8) }
      format.json { @clientes = clientes }
      format.pdf do
        send_data clientes_pdf(clientes),
          filename: "clientes_#{Date.current.strftime('%Y%m%d')}.pdf",
          type: "application/pdf",
          disposition: "attachment"
      end
    end
  end

  def show
    @veiculos = @cliente.veiculos.includes(:ordem_servicos).order(:marca, :modelo)
  end

  def new
    @cliente = Cliente.new
  end

  def edit
  end

  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: "Cliente cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @cliente.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to @cliente, notice: "Cliente atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @cliente.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @cliente.destroy!

    respond_to do |format|
      format.html { redirect_to clientes_path, notice: "Cliente removido com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_cliente
      @cliente = Cliente.find(params.expect(:id))
    end

    def cliente_params
      params.expect(cliente: [ :name, :phone, :email ])
    end

    def clientes_pdf(clientes)
      rows = clientes.map { |cliente| [ cliente.id, cliente.name, cliente.phone, cliente.email ] }
      ReportPdf.generate(title: "Relatorio de clientes", headers: [ "ID", "Nome", "Telefone", "Email" ], rows:)
    end
end
