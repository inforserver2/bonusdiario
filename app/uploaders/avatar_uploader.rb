# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     "/images/users/" + [version_name, "#{model.gender_id}.png"].compact.join('_')
   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  version :mini do
     process :resize_to_fill => [30, 30]
  end
  version :thumb do
     process :resize_to_fill => [60, 60]
  end
  version :medium do
     process :resize_to_fill => [120, 120]
  end
  version :normal do
     process :resize_to_fill => [240, 240]
  end


  # Add a white list of extensions which are allowed to be uploaded.<F12>
  # For images you might use something like this:
  def extension_white_listu
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  def filename
    "image.png" if original_filename
  end

end
