class Customer < ApplicationRecord
  has_paper_trail :ignore => [:created_at, :updated_at]
  has_many :entries
  validates :name, presence: true
  before_validation :strip_whitespace

  def strip_whitespace
    self.name = self.name.strip unless self.name.nil?
    self.address = self[:address].gsub("\n", '').squeeze(' ') unless self.address.nil?
  end

end
