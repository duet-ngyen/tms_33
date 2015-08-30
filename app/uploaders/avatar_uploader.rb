class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  version :avatar_header do
    cloudinary_transformation width: 48, height: 48, crop: :thumb,
      gravity: :face, radius: 5, background: "#222222"
  end

  version :avatar_profile do
    cloudinary_transformation width: 200, crop: :fit,
      gravity: :north, radius: 5
  end
end
