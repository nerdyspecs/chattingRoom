class User < ApplicationRecord
  has_many :message, dependent: :delete_all
  has_many :room, dependent: :delete_all
end
