class Item < ApplicationRecord
  has_paper_trail :ignore => [:created_at, :updated_at]
  include RailsSortable::Model
  belongs_to :entry
  validates :name, :price, presence: true
  attr_accessor :count_hours
  attr_accessor :count_mins
  set_sortable :sort
  after_initialize :init

  def init
    self.item_date ||= Date.today
  end
  #getter
  def count_mins
    @count_mins = self.count % 60
  end

  #setter
  def count_mins=(value)
    self.count = ( self.count * 60 ) + value.to_i 
  end

  #getter
  def count_hours
    @count_hours = self.count / 60
  end

  #setter
  def count_hours=(value)
    self.count = value
  end
end
