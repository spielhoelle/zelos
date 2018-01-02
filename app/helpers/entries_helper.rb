module EntriesHelper
   
  def get_items_total(entry)
    entry.items.map{|i| (i.price * ( (i.count == 0 ? 60 : i.count) / 60.00)).to_s.to_f.round(2)}.inject(0, :+)
  end
end
