class Facility < ApplicationRecord
  has_many :seniors, dependent: :destroy
  has_many :workers, dependent: :destroy

  acts_as_google_authenticated lookup_token: :salt, drift: 60, issuer: 'ヒヤリ管理システム'
  before_save {|record| record.salt = SecureRandom.hex unless record.salt }
  after_create {|record| record.set_google_secret }

  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  has_secure_password validations: false

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

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

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    email = auth[:info][:email]

    self.find_or_create_by(provider: provider, uid: uid, email: email) do |facility|
      facility.name = name
      facility.email = email
    end
  end

end
