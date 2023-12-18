# Prefectureから地域(Area)を定義する
class Area < ActiveHash::Base
  # 地域と都道府県IDのマッピング
  AREA_PREFECTURE_MAPPING = {
    '北海道' => [2],
    '東北' => (3..8).to_a,
    '関東' => (9..15).to_a,
    '中部' => (16..25).to_a,
    '近畿' => (26..31).to_a,
    '中国四国' => (32..40).to_a,
    '九州' => (41..47).to_a,
    '沖縄' => [48]
  }.freeze

  # 地域名からprefecture_idを割り出す
  def self.prefecture_ids(area_name)
    AREA_PREFECTURE_MAPPING[area_name] || []
  end

  # prefecture_idから地域名を割り出す
  def self.area_name(prefecture_id)
    AREA_PREFECTURE_MAPPING.find do |_area, ids|
      ids.include?(prefecture_id)
    end&.first
  end

  # セレクトボックス用のデータを生成する
  def self.select_options
    AREA_PREFECTURE_MAPPING.map { |area, ids| [area, ids.join(',')] }
  end

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
