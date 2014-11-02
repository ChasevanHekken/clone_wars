
class Contact

  attr_reader :name, :email, :subject, :message, :id

  def initialize(attributes)
    @name = attributes["name"]
    @email = attributes["email"]
    @subject = attributes["subject"]
    @message = attributes["message"]
    @id = attributes["id"]
  end

  def save
    ContactStore.create(to_h)
  end

  def to_h
    {
      "name" => name,
      "email" => email,
      "subject" => subject,
      "message" => message
    }
  end

end