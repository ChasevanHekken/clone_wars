require_relative '../db/models'
require_relative 'rewrite'

class CategoryStore

  def self.add_catering_items_to_categories
    DB['SELECT * FROM categories'].all.map do |category_hash|
      category_hash.merge(:catering_items => DB.from(:catering_items).where(:category_id => category_hash[:id]).to_a)
    end
  end

end
