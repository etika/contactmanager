class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # searchkick word_start: [:email]
  # def search_data
  #   {
  #     email: email
  #   }
  # end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :contacts
  belongs_to :manager, class_name: "User"
  has_many :employees, class_name: "User", foreign_key: :manager_id
end
