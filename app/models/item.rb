class Item < ApplicationRecord
  has_paper_trail :ignore => [:created_at, :updated_at]
  include RailsSortable::Model
  belongs_to :entry
  validates :name, :price, presence: true

  set_sortable :sort

end
