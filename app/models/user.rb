class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    attr_accessor :remember_token

    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length:  { maximum: 50 }
    validates :email, presence: true, length: { maximum: 250 }
    validates :email, format: {with: VALID_EMAIL_REGEX },
                      uniqueness: true
                    
    
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
    end

    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    def session_token
        remember_digest || remember
    end

    def feed
        Micropost.where("user_id = ?", id)
    end

end
