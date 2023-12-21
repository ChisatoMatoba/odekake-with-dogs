// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "preview"
import "preview_dog"
import "tab"
import "modal"
import "facility_index"
import "tags"

import "jquery";
window.jQuery = jQuery;
window.$ = jQuery;

import "select2";
// js-searchable クラスをつけたらSELECT2タグになるようにする
document.addEventListener("turbo:load", () => {
  $('.js-searchable').select2({
    width: '100%',
    allowClear: true,
    theme: "bootstrap-5",
		placeholder: "検索したいタグ名を3つまで選択して下さい",
		maximumSelectionSize: 3,
    // コンテナにすべてのCSSを適用
    containerCssClass: ':all:'
  });
});

// 一度ページを離れてからブラウザバックなどした際に重複して表示されてしまうのを防ぐために
// ページがキャッシュされる前にselect2が適用された要素をクリーンアップ
document.addEventListener("turbo:before-cache", () => {
  $('.js-searchable').each(function() {
    if ($(this).data('select2')) {
      $(this).select2('destroy');
    }
  });
});
