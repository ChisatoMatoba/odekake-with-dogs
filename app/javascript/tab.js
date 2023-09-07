// タブがクリックされたときの処理関数を定義
function handleTabClick(e) {
  e.preventDefault(); // リンクのデフォルトの動作を無効にする

  // クリックされたタブのhref属性から対応するコンテンツのIDを取得
  var targetId = $(this).attr('data-bs-target');

  // すべてのコンテンツを非表示にし、クリックされたタブに関連するコンテンツを表示
  $('.tab-pane').removeClass('show active');
  $(targetId).addClass('show active');
}


// ページ読み込み時にクリックイベントをバインド
$(document).ready(function() {
  $('.tab_change').on('click', handleTabClick);
});

// Turbo フレームワークの turbo:load イベントでクリックイベントを再バインド
document.addEventListener('turbo:load', function() {
  $('.tab_change').off('click', handleTabClick); // 既存のクリックイベントを削除
  $('.tab_change').on('click', handleTabClick); // クリックイベントを再バインド
});
