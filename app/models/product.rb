class Product < ApplicationRecord
  belongs_to :user
  has_many :attachments


  validates_presence_of :name, :description, :attachments

  def files=(array_of_files = [])
    array_of_files.each do |f|
      attachments.build(image: f, product: self)
    end
  end
end
