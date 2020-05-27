class Facility < ApplicationRecord
  has_many :seniors, dependent: :destroy
  has_many :workers, dependent: :destroy

  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  # has_secure_password
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # has_secure_password validations: false, on: :sns_login

  # validate(on: :update) do |record|
  #   record.errors.add(:password, :blank) unless record.password_digest.present?
  # end
  #
  # validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED, on: :update
  # validates_confirmation_of :password, allow_blank: true, on: :update

  # 渡された文字列のハッシュ値を返します。
  def Facility.digest(string)
    cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def Facility.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = Facility.new_token
    update_attribute(:remember_digest, Facility.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 施設ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end

  # def self.from_omniauth(auth)
  #   where(id: auth.id, provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |facility|
  #     facility.provider = auth.provider
  #     facility.uid = auth.uid
  #     facility.name = auth.info.name
  #     facility.email = auth.info.email
  #     facility.image = auth.info.image
  #     facility.oauth_token = auth.credentials.token
  #     facility.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     return facility
  #   end
  # end

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    email = auth[:info][:email]
    image = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid, email: email) do |facility|
      facility.name = name
      facility.email = email
      facility.image = image
    end
  end

end
