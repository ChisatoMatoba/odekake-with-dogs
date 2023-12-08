require 'rails_helper'

RSpec.describe 'Home', type: :system do
  it 'shows the root page' do
    visit root_path
    save_screenshot('screenshots/home_page.png') # スクリーンショットを保存
  end
end
