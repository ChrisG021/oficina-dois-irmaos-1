json.extract! cliente, :id, :name, :phone, :email, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
