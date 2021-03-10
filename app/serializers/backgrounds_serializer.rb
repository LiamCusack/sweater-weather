class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :location, :image_url, :photographer
end
