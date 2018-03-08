class Contact < ActiveRecord::Base
  searchable do
    text :name, :email, :phone_number
    string :phone_number, multiple: true
    # text :addresses do |Contact|
    #   contact.addresses.map { |tag| tag.city }
    # end
  end
  has_many :addresses
  belongs_to :user

  def create_contacts(contacts)
    contacts.each do |contact|
      phone_number = contact[:phone_numbers].map{|contact| contact.values.last} if contact[:phone_numbers].present?
      Contact.create(name: contact[:name],email: contact[:email], phone_number: phone_number, user_id: current_user.id)
    end
  end
end
