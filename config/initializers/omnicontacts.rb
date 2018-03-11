require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, {:redirect_path => "/home/contacts_callback", :ssl_ca_file => "/etc/ssl/certs/curl-ca-bundle.crt" }
end
