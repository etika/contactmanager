require 'elasticsearch/model'
class Contact < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # searchkick word_start: [:email]
  self.per_page = 10

  has_many :addresses
  belongs_to :user

  # def search_data
  #   {
  #     email: email
  #   }
  # end

  # searchable do
  #   text :name, :email, :phone_number
  #   string :phone_number, multiple: true
  #   text :state do  # this one for full text search
  #     addresses.map(&:state).compact.join(" ")
  #   end
  #   text :city do  # this one for full text search
  #     addresses.map(&:city).compact.join(" ")
  #   end
  #   text :lane do
  #     addresses.map(&:lane).compact.join(" ")
  #   end
  #   text :pincode do
  #     addresses.map(&:pincode).compact.join(" ")
  #   end
  #   text :country do
  #     addresses.map(&:country).compact.join(" ")
  #   end
  # end

def self.search(query)
  __elasticsearch__.search(
    {
      query: {
        multi_match: {
          query: query,
          fields: ['email', 'name', 'phone_number', 'addresses.lane' ],
        }
      },
      highlight: {
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        fields: {
          title: {},
          text: {}
        }
      }
    }
  )
end

  def self.create_contacts(contacts, id)
    contacts.each do |contact|
      phone_number = contact[:phone_numbers].map{|contact| contact.values.last} if contact[:phone_numbers].present?
      contact = Contact.create(name: contact[:name],email: contact[:email], phone_number: phone_number, user_id: id)
      contact.addresses.create(lane: 'Anna', city:'new delhi', state: 'chennai',pincode: '1100011', country: 'india')
    end
  end
end
