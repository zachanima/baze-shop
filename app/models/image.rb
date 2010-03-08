class Image < ActiveRecord::Base
  belongs_to :template
  has_and_belongs_to_many :categorizations
  validates_presence_of :name

  has_attached_file :data, :styles => {
    :small => '200x200#',
    :original => '800x600>' }
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => [
    'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png' ]
end
