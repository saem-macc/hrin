json.extract! post, :id, :title, :image_data, :created_at, :updated_at
json.url post_url(post, format: :json)
