class SearchConditionBuilder
  def initialize(params)
    @params = params
    @search_conditions = {}
  end

  def build
    applied_search_condition
    @search_conditions
  end

  private

  # 施設の地域・都道府県の検索条件を作成
  def location_search_condition
    return if @params[:q][:location].blank?

    location = @params[:q][:location]
    # カンマ区切りがある場合は地域とみなして、検索結果を設定する
    @search_conditions['地域'] =
      if location.include?(',')
        Prefecture.find_by(id: location.split(',').first.to_i)&.area&.name
      else
        Prefecture.find_by(id: location)&.name
      end
  end

  # 施設のカテゴリー、条件の検索条件を作成
  def facility_search_conditions
    # 施設のカテゴリー
    @search_conditions['施設のカテゴリー'] = Category.find_by(id: @params[:q][:facility_category_id_eq])&.name if @params[:q][:facility_category_id_eq].present?

    # 施設の条件
    selected_condition_ids = @params[:q][:facility_conditions_id_in].reject(&:blank?).map(&:to_i)
    @search_conditions['施設の条件'] = Condition.where(id: selected_condition_ids).pluck(:category).join(', ') \
    if selected_condition_ids.present?
  end

  # タグの検索条件を作成
  def post_tag_search_condition
    selected_tag_ids = @params[:q][:tags_id_in].reject(&:blank?).map(&:to_i)
    @search_conditions['タグ'] = Tag.where(id: selected_tag_ids).pluck(:name).join(', ') \
    if selected_tag_ids.present?
  end

  # 適用された検索条件の作成
  def applied_search_condition
    # params[:q] が存在しない場合、早期リターン
    return unless @params[:q]

    # 施設の地域・都道府県
    location_search_condition
    # 施設のカテゴリー、条件
    facility_search_conditions
    # 投稿の満足度
    @search_conditions['満足度'] = "#{Rating.find_by(id: @params[:q][:rating_id_lteq])&.name}以上" if @params[:q][:rating_id_lteq].present?
    # 投稿者
    @search_conditions['投稿者'] = User.find_by(id: @params[:q][:user_id_eq])&.nickname if @params[:q][:user_id_eq].present?
    # タグ
    post_tag_search_condition
  end
end
