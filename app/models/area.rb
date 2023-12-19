# Prefectureから地域(Area)を定義する
class Area < ActiveHash::Base
  include ActiveHash::Associations
  has_many :prefectures

  # 地域と都道府県IDのマッピング
  self.data = [
    { id: 1, name: '北海道' },
    { id: 2, name: '東北' },
    { id: 3, name: '関東' },
    { id: 4, name: '中部' },
    { id: 5, name: '近畿' },
    { id: 6, name: '中国四国' },
    { id: 7, name: '九州' },
    { id: 8, name: '沖縄' }
  ]

  # NOTE: タブ表示のビューに使用、今後使用する場合は、ヘルパーに移すなどの処置をすること
  # タブ表示のためのロジック
  def self.find_by(prefecture_id:)
    case prefecture_id
    when 2
      %w[北海道 nav-hokkaido-content nav-hokkaido-tab]
    when 3..8
      %w[東北 nav-tohoku-content nav-tohoku-tab]
    when 9..15
      %w[関東 nav-kanto-content nav-kanto-tab]
    when 16..25
      %w[中部 nav-chubu-content nav-chubu-tab]
    when 26..31
      %w[近畿 nav-kinki-content nav-kinki-tab]
    when 32..40
      %w[中国四国 nav-chushikoku-content nav-chushikoku-tab]
    when 41..47
      %w[九州 nav-kyushu-content nav-kyushu-tab]
    when 48
      %w[沖縄 nav-okinawa-content nav-okinawa-tab]
    end
  end
end
