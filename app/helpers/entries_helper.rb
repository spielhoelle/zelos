module EntriesHelper

  def get_items_total(entry)
    entry.items.map{|i|  ((( i.id.present? ? (i.price * ( i.count == 0 ? 60 : i.count)) : 0 )/ 60.00) ).to_s.to_f.round(2)}.inject(0, :+)
  end
  def get_tax_items_total(entry)
    entry.items.select { |item| !item.expense}.map{|i|  ((( i.id.present? ? (i.price * ( i.count == 0 ? 60 : i.count)) : 0 )/ 60.00) ).to_s.to_f.round(2)}.inject(0, :+)
  end
end
