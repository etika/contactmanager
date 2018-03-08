require "net/http"
class CreateContactWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(current_user, contacts)
    contacts.each do |contact|
      phone_number = contact[:phone_numbers].map{|contact| contact.values.last} if contact[:phone_numbers].present?
      Contact.create(name: contact[:name],email: contact[:email], phone_number: phone_number, user_id: current_user.id)
    end
  end
end
