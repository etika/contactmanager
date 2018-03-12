class HomeController < ApplicationController
  def index
  end

  def contacts_callback
    unless request.env['omnicontacts.contacts'].blank? || Contact.where(user_id: current_user.id).count > 0
      @contacts = request.env['omnicontacts.contacts']
      Rails.logger.info "Contacts: #{@contacts}"
      Contact.create_contacts(@contacts, current_user.id)
    end
    redirect_to contacts_path
  end

  def failure
    redirect_to :back
  end
end
