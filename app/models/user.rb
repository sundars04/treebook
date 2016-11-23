class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :statuses
  has_many :user_friendships
  has_many :friends,-> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships
  has_many :pending_user_friendships, -> { where  state: "pending"  }, class_name: 'UserFriendship', foreign_key: :user_id
  has_many :pending_friends, through: :pending_user_friendships, source: :friend
  has_many :requested_user_friendships, -> { where  state: "requested"  }, class_name: 'UserFriendship', foreign_key: :user_id
  has_many :requested_friends, through: :pending_user_friendships, source: :friend
  has_many :blocked_user_friendships, -> { where  state: "blocked"  }, class_name: 'UserFriendship', foreign_key: :user_id
  has_many :blocked_friends, through: :pending_user_friendships, source: :friend
  # has_many :friends, through: :user_friendships,
  #                    conditions: { user_friendships: { state: 'accepted' } }
  # has_many :pending_user_friendships, class_name: 'UserFriendship',
  #                                     foreign_key: :user_id,
  #                                     conditions: { state: 'pending' }
  # has_many :pending_friends, through: :pending_user_friendships, source: :friend

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
                          uniqueness: true
                          

  def full_name
    first_name + " " + last_name
  end

  def to_param
    profile_name
  end

  def gravatar_url
    stripped_email = email.strip    
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)    
    "https://secure.gravatar.com/avatar/#{hash}"    
  end

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end
end
