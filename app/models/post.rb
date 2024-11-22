class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)
  validates_presence_of :image
  validates :title, presence: true

end
