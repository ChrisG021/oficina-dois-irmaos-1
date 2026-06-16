# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_13_185000) do
  create_table "clientes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clientes_on_email", unique: true
  end

  create_table "ordem_servicos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "data_entrada", null: false
    t.date "data_saida"
    t.text "descricao", null: false
    t.string "status", default: "Aberta", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "veiculo_id", null: false
    t.index ["veiculo_id"], name: "index_ordem_servicos_on_veiculo_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "veiculos", force: :cascade do |t|
    t.integer "ano"
    t.integer "cliente_id", null: false
    t.datetime "created_at", null: false
    t.string "marca"
    t.string "modelo"
    t.string "placa"
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_veiculos_on_cliente_id"
    t.index ["placa"], name: "index_veiculos_on_placa", unique: true
  end

  add_foreign_key "ordem_servicos", "veiculos"
  add_foreign_key "veiculos", "clientes"
end
