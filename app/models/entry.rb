class Entry < ActiveRecord::Base
  has_paper_trail :ignore => [:created_at, :updated_at]
  has_many :items, -> { order 'items.sort'}
  belongs_to :customer

  accepts_nested_attributes_for :items, allow_destroy: true
  accepts_nested_attributes_for :customer

  after_update :sanitize
  before_save :default_values
  after_initialize :init

  def init
    self.invoice_date ||= Date.today
    self.delivery_date ||= Date.today
    self.invoice_number ||= Time.now.to_i
  end

  def default_values
    if self.title.nil? || self.title.empty?
      if self.customer.present?
        self.title = self.customer.name
      else
        self.title = self.invoice_number
      end
    end
  end

  def sanitize
    self.notes = self[:notes].gsub("\n", '').squeeze(' ')
    self.private_note = self[:private_note].gsub("\n", '').squeeze(' ')
  end

  def self.total
    self.collect { |x| x.items.collect{|y| y.price.to_f}.reduce(0, :+) }
  end

end
