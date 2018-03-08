class HomeController < ApplicationController
  def index
  end

  def contacts_callback
    unless request.env['omnicontacts.contacts'].blank?
      @contacts = request.env['omnicontacts.contacts']
      Contact.create_contacts(@contacts)
    end
  end
end
