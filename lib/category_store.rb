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

  def self.catering_items_and_categories
    database['SELECT * FROM categories'].all.map do |category_hash|
      category_hash.merge(:catering_items => database.from(:catering_items).where(:category_id => category_hash[:id]).to_a)
    end
  end

  def self.add_catering_item(category, title, description, half_price, full_price)
    category_id = ensure_category_exists(category)
    catering_items_dataset.insert(:id => (catering_items_dataset.count + 1),
                                  :title => title,
                                  :description => description,
                                  :half_price => half_price,
                                  :full_price => full_price,
                                  :category_id => category_id)
  end

  def self.add_category(id, name)
    category_dataset.insert(:id => id, :name => name)
  end

  def self.ensure_category_exists(name)
      result = database['SELECT id FROM categories where name = ?', name]
    if result.empty?
      add_category(category_dataset.count + 1, name)
    else
      result.first[:id]
    end
  end

end
