class Attachment < ApplicationRecord
  belongs_to :product
  has_attached_file :image, :styles => { large: '600x600>', medium: '300x300>', thumb: '150x150#' },
                    :path => ":rails_root/public/system/products/images/:style/:basename.:extension",
                    :url => "/system/products/images/:style/:basename.:extension"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image
end
