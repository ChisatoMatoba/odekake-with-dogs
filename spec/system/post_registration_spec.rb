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

  it '施設詳細画面から新規投稿画面に遷移後、その施設の情報が表示される' do
    # 施設詳細画面へ移動する
    visit facility_path(facility)
    # 「この施設のお出かけ情報を登録する」ボタンを押す
    click_on 'この施設のおでかけ情報を登録する'
    # 新規投稿ページへ遷移することを確認する
    expect(page).to have_current_path(new_facility_post_path(facility))
    expect(page).to have_text('おでかけ情報を入力')
    # 施設の情報が表示されていることを確認する
    expect(page).to have_text('テスト施設')
  end

  it '正しい情報(タグ以外)を入力すれば投稿でき、投稿詳細画面に移動する' do
    # 新規投稿ページへ移動する
    visit new_facility_post_path(facility)
    # 正しい投稿内容を入力する
    fill_in_post_form
    # 投稿ボタンを押す
    click_on '投稿する'
    # 登録した投稿の内容が投稿詳細ページに表示されていることを確認
    expect(page).to have_text("#{user.nickname}さんのレビュー")
    expect(page).to have_text('楽しかった')
  end

  it '正しい情報＋タグ1つを入力すれば投稿でき、投稿詳細画面に移動する' do
    # 新規投稿ページへ移動する
    visit new_facility_post_path(facility)
    # 正しい投稿内容を入力する
    fill_in_post_form
    # タグを入力する
    fill_in 'input-tag', with: 'タグ'
    # タグを追加する
    click_on 'タグを追加'
    # 投稿ボタンを押す
    click_on '投稿する'
    # 登録した投稿の内容が投稿詳細ページに表示されていることを確認
    expect(page).to have_text("#{user.nickname}さんのレビュー")
    expect(page).to have_text('楽しかった')
    expect(page).to have_text('タグ')
  end

  it '正しい情報＋タグ複数を入力すれば投稿でき、投稿詳細画面に移動する' do
    # 新規投稿ページへ移動する
    visit new_facility_post_path(facility)
    # 正しい投稿内容を入力する
    fill_in_post_form
    # タグを入力する
    fill_in 'input-tag', with: 'タグ'
    # タグを追加する
    click_on 'タグを追加'
    # タグを入力する
    fill_in 'input-tag', with: 'タグその2'
    # タグを追加する
    click_on 'タグを追加'
    # 投稿ボタンを押す
    click_on '投稿する'
    # 登録した投稿の内容が投稿詳細ページに表示されていることを確認
    expect(page).to have_text("#{user.nickname}さんのレビュー")
    expect(page).to have_text('楽しかった')
    expect(page).to have_text('タグ')
    expect(page).to have_text('タグその2')
  end

  private

  def fill_in_post_form
    fill_in 'post[people_num]', with: '3'
    fill_in 'post[dogs_num]', with: '3'
    select '★★★★☆', from: 'item-category'
    fill_in 'post[review]', with: '楽しかった'
    # 画像を添付する
    attach_file('post[images][]', Rails.root.join('public/images/test_image.png'))
  end
end
