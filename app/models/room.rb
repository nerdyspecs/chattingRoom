class Room < ApplicationRecord
  belongs_to :user
  has_many :message, dependent: :delete_all

end
