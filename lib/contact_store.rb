require 'yaml/store'

class ContactStore

  def self.database
    return @database if @database

    @database ||= YAML::Store.new('db/contacts')
    @database.transaction do
      @database['contacts'] ||= []
    end
    @database
  end

  def self.all
    contacts = []
    raw_contacts.each_with_index do |data, i|
      contacts << Contact.new(data.merge("id" => i))
    end
    contacts
  end

  def self.raw_contacts
    raw_contacts = database.transaction do |db|
      db['contacts'] || []
    end
  end

  def self.delete(position)
    database.transaction do
      database['contacts'].delete_at(position.to_i)
    end
  end

  def self.find(id)
    raw_contact = (find_raw_contact(id))
    Contact.new(raw_contact.merge("id" => id))
  end

  def self.find_raw_contact(id)
    database.transaction do
      database['contacts'].at(id)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['contacts'][id] = data
    end
  end

  def self.create(data)
    database.transaction do
      database['contacts'] << data
    end
  end

end