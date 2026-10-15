class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :registerable
  devise :two_factor_authenticatable, otp_secret_encryption_key: Rails.application.credentials.otp_secret
  devise :recoverable, :rememberable, :validatable

  has_many :email_messages
  has_many :job_applications
  has_many :auto_suggestions
  has_many :comments
  has_many :flashcards
  has_many :frustrations
  has_many :histories
  has_many :interview_cheat_sheets
  has_many :learnings
  has_many :memories
  has_many :my_offers
  has_many :reflections
  has_many :shift_shames
  has_many :stories
  has_many :tasks
  has_many :topics
  has_many :weekly_plans
  has_many :englishes

 
  def search(search_term) 
    owned_ids = []
    owned_records = []
    User.reflect_on_all_associations(:has_many).each do |association|
      next unless self.respond_to?(association.name)
    
      owned_ids += self.public_send(association.name)
                                  .where("CAST(#{association.klass.table_name}.* AS TEXT) \
                                    ILIKE ?", "%#{search_term}%").pluck(:id)

      owned_records += owned_ids.map { |id| { class_name: association.klass.name, id: id } }
    end

    owned_records
  end



  def otp_qr_code
    issuer = "app.oshit10x.xyz"
    self.otp_secret ||= User.generate_otp_secret
    save! if otp_secret_changed?
    otp_provisioning_uri("Amin:#{email}", issuer: issuer)
  end

  
  # current_user.otp_required_for_login = true
  # current_user.otp_secret = User.generate_otp_secret
  # current_user.save!

         #  :omniauthable
  # omniauth_providers: [:google_oauth2]

  # app/models/user.rb

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first

  #   # Uncomment the section below if you want users to be created if they don't exist
  #   # unless user
  #   #     user = User.create(name: data['name'],
  #   #        email: data['email'],
  #   #        password: Devise.friendly_token[0,20]
  #   #     )
  #   # end
  #   user
  # end
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     # Optional: user.name = auth.info.name, etc.
  #   end
  # end
end
