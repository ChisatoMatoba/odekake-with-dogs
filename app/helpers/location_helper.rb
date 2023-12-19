module LocationHelper
  # 検索フォームのセレクトボックス用
  def location_select_options
    {
      'エリア' => Area.all.map { |area| [area.name, area.prefectures.pluck(:id).join(',')] },
      '都道府県' => Prefecture.all.pluck(:name, :id)
    }
  end

  # NOTE: タブ表示のビューにのみ使用、コメントアウト部分を削除するタイミングで一緒に削除
  # 投稿を地域ごとにグループ化する
  def post_groupedby_area(posts)
    areas = {}
    posts.each do |post|
      area = post.facility.prefecture.area.name
      areas[area] ||= []
      areas[area] << post
    end
    areas
  end
end
