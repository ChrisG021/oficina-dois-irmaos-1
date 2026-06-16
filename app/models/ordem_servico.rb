class OrdemServico < ApplicationRecord
  STATUS = [ "Aberta", "Em andamento", "Aguardando pecas", "Concluida", "Cancelada" ].freeze

  belongs_to :veiculo
  has_one :cliente, through: :veiculo

  before_validation :definir_status_padrao

  validates :descricao, presence: true, length: { minimum: 5, maximum: 1_000 }
  validates :status, presence: true, inclusion: { in: STATUS }
  validates :valor, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :data_entrada, presence: true
  validate :data_saida_nao_pode_anteceder_entrada

  scope :recentes, -> { order(created_at: :desc) }
  scope :abertas, -> { where(status: [ "Aberta", "Em andamento", "Aguardando pecas" ]) }

  def status_badge_class
    case status
    when "Aberta" then "text-bg-primary"
    when "Em andamento" then "text-bg-warning"
    when "Aguardando pecas" then "text-bg-secondary"
    when "Concluida" then "text-bg-success"
    when "Cancelada" then "text-bg-danger"
    else "text-bg-light"
    end
  end

  private

    def definir_status_padrao
      self.status = "Aberta" if status.blank?
      self.data_entrada ||= Date.current
    end

    def data_saida_nao_pode_anteceder_entrada
      return if data_saida.blank? || data_entrada.blank?

      errors.add(:data_saida, "nao pode ser anterior a data de entrada") if data_saida < data_entrada
    end
end
