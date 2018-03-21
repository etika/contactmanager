class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :contacts, dependent: :destroy
  belongs_to :manager, class_name: "User"
  has_many :employees, class_name: "User", foreign_key: :manager_id, dependent: :destroy
end
