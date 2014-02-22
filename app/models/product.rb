class Product < ActiveRecord::Base
	default_scope :order => 'title'
	validates :title, :description, :presence =>true
	validates :price, :numericality => { :greater_than => 0 }
	validates :title, :uniqueness => true
	validates :image_url, :allow_blank => true, :format => {    
	:with    => %r{\.(gif|jpg|png)\z}i,
    :message => 'must be a URL for GIF, JPG or PNG image.'
	
	}
	
  has_many :line_items
 
  before_destroy :ensure_not_referenced_by_any_line_item
  private
 
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end

