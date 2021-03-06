require 'elasticsearch/model'
class Contact < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :addresses, dependent: :destroy
  belongs_to :user

  after_commit on: [:create] do
    __elasticsearch__.index_document if self.published?
  end

  after_commit on: [:update] do
    __elasticsearch__.update_document if self.published?
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_document if self.published?
  end

  def as_indexed_json(options={})
    as_json(
      only: [:email, :name, :phone_number],
      include: {addresses:{only: [:lane, :city, :state, :country, :pincode]}}
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
