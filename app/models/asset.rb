class Asset < ActiveRecord::Base
  has_attached_file :asset
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/
  belongs_to :ticket
end
