require 'elasticsearch/model'
class Address < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :contact
end
