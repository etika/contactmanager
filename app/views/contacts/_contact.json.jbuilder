json.extract! contact, :id, :name, :email, :phone_number, :created_at, :updated_at
json.url contact_url(contact, format: :json)
