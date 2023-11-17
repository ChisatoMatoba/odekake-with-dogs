class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :dogs
  has_many :facilities

  validates :nickname,           presence: true
  validates :birthday,           presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  # ユーザーの年代を計算
  require 'happybirthday'
  def age_group
    birthday = Happybirthday.born_on(self.birthday)
    case birthday.age.years_old
    when 0..9
      "0〜9歳"
    when 10..19
      "10〜19歳"
    when 20..29
      "20〜29歳"
    when 30..39
      "30〜39歳"
    when 40..49
      "40〜49歳"
    when 50..59
      "50〜59歳"
    when 60..69
      "60〜69歳"
    when 70..Float::INFINITY
      "70歳以上"
    else
      "年齢非公開"
    end
  end

end
