class Veiculo < ApplicationRecord
  belongs_to :cliente
  has_many :ordem_servicos, dependent: :destroy

  before_validation :normalizar_placa

  validates :placa, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[A-Z]{3}-?[0-9][A-Z0-9][0-9]{2}\z/, message: "deve estar no formato ABC-1234 ou ABC1D23" }
  validates :marca, :modelo, presence: true
  validates :ano, presence: true,
                  numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Date.current.year + 1 }

  def nome_completo
    "#{marca} #{modelo} - #{placa}"
  end

  private

    def normalizar_placa
      self.placa = placa.to_s.upcase.strip
    end
end
