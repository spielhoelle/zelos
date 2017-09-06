module EntriesHelper
   
  def get_items_total(entry)
    entry.items.map{|i| (i.price * i.count).to_s.to_f.round(2)}.inject(0, :+)
  end
end
