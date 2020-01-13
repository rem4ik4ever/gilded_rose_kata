def update_quality(items)
  items.each do |item|
    exception_item_list = ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert', 'Conjured Mana Cake']
    is_legendary = item.name == 'Sulfuras, Hand of Ragnaros'
    if !exception_item_list.include?(item.name)
      item.quality -= 1 if item.quality > 0 && !is_legendary
    elsif item.name == 'Conjured Mana Cake'
      item.quality -= 2 if item.quality > 0 && !is_legendary
    else
      if item.quality < 50
        item.quality += 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality += 1 if item.quality < 50 && item.sell_in < 11
          item.quality += 1 if item.sell_in < 6 && item.quality < 50 
        end
      end
    end
    
    item.sell_in -= 1 if !is_legendary
    
    if item.sell_in < 0
      case item.name
      when "Aged Brie"
        item.quality += 1 if item.quality < 50
      when 'Backstage passes to a TAFKAL80ETC concert'
        item.quality = 0
      when 'Conjured Mana Cake'
        item.quality -= 2 if !is_legendary && item.quality > 0
      else 
        item.quality -= 1 if !is_legendary && item.quality > 0
      end
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

