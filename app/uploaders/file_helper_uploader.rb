class FileHelperUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "http://phi7tql9h.bkt.clouddn.com/#{model.id}.mp4"
  end


end
