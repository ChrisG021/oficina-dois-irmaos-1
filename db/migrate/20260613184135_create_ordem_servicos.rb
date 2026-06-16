class CreateOrdemServicos < ActiveRecord::Migration[8.1]
  def change
    create_table :ordem_servicos do |t|
      t.references :veiculo, null: false, foreign_key: true
      t.text :descricao, null: false
      t.string :status, null: false, default: "Aberta"
      t.decimal :valor, precision: 10, scale: 2, null: false, default: 0
      t.date :data_entrada, null: false
      t.date :data_saida

      t.timestamps
    end
  end
end
