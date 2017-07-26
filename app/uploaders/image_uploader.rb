class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  process resize_to_limit: [200, 200]
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    time = Time.now
    name = "#{time.strftime('%Y%m%d%H%M%S')}.#{file.extension}" if original_filename.present?
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
