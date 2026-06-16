class Cliente < ApplicationRecord
  has_many :veiculos, dependent: :destroy
  has_many :ordem_servicos, through: :veiculos

  before_validation :normalizar_email

  validates :name, presence: true, length: { minimum: 3, maximum: 80 }
  validates :phone, presence: true, format: { with: /\A[\d\s()+-]{10,20}\z/, message: "deve ter entre 10 e 20 digitos" }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def contato_principal
    "#{phone} | #{email}"
  end

  private

    def normalizar_email
      self.email = email.to_s.strip.downcase
    end
end
