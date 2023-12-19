module LocationHelper
  # 検索フォームのセレクトボックス用
  def location_select_options
    {
      'エリア' => Area.all.map { |area| [area.name, area.prefectures.pluck(:id).join(',')] },
      '都道府県' => Prefecture.all.pluck(:name, :id)
    }
  end
end
