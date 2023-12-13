require 'rails_helper'

RSpec.describe '施設新規登録', type: :system do
  # テスト用のユーザーを作成
  let!(:user) { FactoryBot.create(:user) }
  # テスト用の施設を作成
  let!(:facility) { FactoryBot.create(:facility, user: user, place_name: 'テスト施設') }

  before do
    # 事前にサインインしておく
    sign_in user
  end

  it '正しい情報を入力すれば施設を編集できて、施設詳細画面に移動する' do
    # 施設詳細画面へ遷移する
    visit facility_path(facility)
    # 編集ボタンをクリックする
    click_on '編集'
    # 施設編集ページへ遷移することを確認する
    expect(page).to have_current_path(edit_facility_path(facility))
    # 施設情報を変更する
    fill_in 'item-name', with: '施設名変更テスト'
    # 登録ボタンを押す
    click_on '登録する'

    # その施設の詳細ページへ遷移することを確認する
    new_facility = Facility.last
    expect(page).to have_current_path(facility_path(new_facility))
    # 登録した施設名がページに表示されていることを確認
    expect(page).to have_text('施設名変更テスト')
  end

  it '自分が作成した施設を削除できて、トップページに移動する' do
    # 施設詳細画面へ遷移する
    visit facility_path(facility)
    # 削除ボタンをクリックする
    click_on '削除'
    # rootページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
    # 施設一覧ページへ遷移する
    visit facilities_path
    # 「全国」の項目をクリックする
    find('.prefecture-row', text: '全国').click
    # 削除された施設がリストに表示されていないことを確認する
    expect(page).not_to have_content(facility.place_name)
  end
end
