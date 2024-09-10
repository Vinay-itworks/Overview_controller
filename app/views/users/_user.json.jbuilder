json.extract! user, :id, :first_name, :last_name, :password, :email, :contact, :current_address, :created_at, :updated_at
json.url user_url(user, format: :json)
