class Ticket < ActiveRecord::Base
  after_create :creator_watches_me
  acts_as_taggable

  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }
                          
  belongs_to :project
  belongs_to :user
  belongs_to :state
  has_many :assets
  accepts_nested_attributes_for :assets
  has_many :comments
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers", class_name: "User"

  paginates_per 30
  
  private
  def creator_watches_me
    self.watchers << user
  end
end
