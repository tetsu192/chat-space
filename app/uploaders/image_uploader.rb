class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  process resize_to_limit: [200, 200]
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
