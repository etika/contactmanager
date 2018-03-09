class Contact < ActiveRecord::Base
  has_many :addresses
  belongs_to :user

  searchable do
    text :name, :email, :phone_number
    string :phone_number, multiple: true
    text :state do  # this one for full text search
      addresses.map(&:state).compact.join(" ")
    end
    text :city do  # this one for full text search
      addresses.map(&:city).compact.join(" ")
    end
    text :lane do
      addresses.map(&:lane).compact.join(" ")
    end
    text :pincode do
      addresses.map(&:pincode).compact.join(" ")
    end
    text :country do
      addresses.map(&:country).compact.join(" ")
    end
  end

  def self.create_contacts(contacts, id)
    contacts.each do |contact|
      phone_number = contact[:phone_numbers].map{|contact| contact.values.last} if contact[:phone_numbers].present?
      contact = Contact.create(name: contact[:name],email: contact[:email], phone_number: phone_number, user_id: id)
      contact.addresses.create(lane: 'Anna', city:'new delhi', state: 'chennai',pincode: '1100011', country: 'india')
    end
  end
end
