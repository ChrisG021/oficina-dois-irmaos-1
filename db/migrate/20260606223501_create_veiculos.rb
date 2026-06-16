class CreateVeiculos < ActiveRecord::Migration[8.1]
  def change
    create_table :veiculos do |t|
      t.string :placa
      t.string :marca
      t.string :modelo
      t.integer :ano
      t.references :cliente, null: false, foreign_key: true

      t.timestamps
    end
  end
end
