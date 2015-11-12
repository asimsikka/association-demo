json.array!(@projxes) do |projx|
  json.extract! projx, :id, :title, :content
  json.url projx_url(projx, format: :json)
end
