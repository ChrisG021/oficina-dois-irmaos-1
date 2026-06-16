class AddUniqueIndexesToClientesAndVeiculos < ActiveRecord::Migration[8.1]
  def change
    add_index :clientes, :email, unique: true
    add_index :veiculos, :placa, unique: true
  end
end
