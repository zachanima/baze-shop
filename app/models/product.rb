class Product < ActiveRecord::Base
  belongs_to :shop
  belongs_to :category
  belongs_to :template
  has_many :orders
  has_many :variations
  has_many :options, :through => :variations
  has_and_belongs_to_many :images
  has_and_belongs_to_many :option_groups

  def name
    self.template.name
  end

  def number
    self.template.number
  end

  def brand
    self.template.brand
  end

  def text
    self.template.text
  end

  def thumbnail
    unless self.images.empty?
      self.images.first.data.url(:small)
    end
  end
end
