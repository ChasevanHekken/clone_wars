require_relative 'rewrite'

class CategoryStore

  def self.database
    SliceWorksApp::DB
  end

  def self.category_dataset
    database.from(:categories)
  end

  def self.catering_items_dataset
    database.from(:catering_items)
  end

  def self.add_catering_items_to_categories
    database['SELECT * FROM categories'].all.map do |category_hash|
      category_hash.merge(:catering_items => database.from(:catering_items).where(:category_id => category_hash[:id]).to_a)
    end
  end

  def self.add_catering_item(category, item_name, half_price, full_price, description)
    category_id = ensure_category_exists(category)

    # catering_items_dataset.insert(.... :category_id => category_id)
  end

  def self.add_category(id, name)
    category_dataset.insert(:id => id, :name => name)
  end

  def self.ensure_category_exists(category)
    result = database['SELECT id FROM categories where name = ?', category]
    if result.empty?
      add_category(category_dataset.count + 1, category)
    else
      result.first[:id]
    end
  end

end
