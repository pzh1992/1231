class Article < ActiveRecord::Base

  #mount_uploader :video_path, FileHelperUploader
  #ATTRIBUTE_TYPES = [ description: Field::Froala, ]

  belongs_to :category


end
