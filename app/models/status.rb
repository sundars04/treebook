class Status < ApplicationRecord
  belongs_to :user

  validates :content, presence: true,
                      length: { minimum: 2 }
  validates :user_id, presence: true                      
end
