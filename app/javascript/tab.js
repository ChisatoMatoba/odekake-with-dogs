// タブがクリックされたときの処理関数を定義
function handleTabClick(e) {
  e.preventDefault(); // リンクのデフォルトの動作を無効にする

  // クリックされたタブのhref属性から対応するコンテンツのIDを取得
  var targetId = this.getAttribute('data-bs-target');

  // すべてのコンテンツを非表示にし、クリックされたタブに関連するコンテンツを表示
  var tabContents = document.querySelectorAll('.tab-pane');
  tabContents.forEach(function(tabContent) {
    tabContent.classList.remove('show', 'active');
  });
  
  var targetContent = document.querySelector(targetId);
  if (targetContent) {
    targetContent.classList.add('show', 'active');
  }
}

// ページ読み込み時にクリックイベントをバインド
document.addEventListener('DOMContentLoaded', function() {
  var tabLinks = document.querySelectorAll('.tab_change');
  tabLinks.forEach(function(tabLink) {
    tabLink.addEventListener('click', handleTabClick);
  });
});

// Turbo フレームワークの turbo:load イベントでクリックイベントを再バインド
document.addEventListener('turbo:load', function() {
  var tabLinks = document.querySelectorAll('.tab_change');
  tabLinks.forEach(function(tabLink) {
    tabLink.removeEventListener('click', handleTabClick); // 既存のクリックイベントを削除
    tabLink.addEventListener('click', handleTabClick); // クリックイベントを再バインド
  });
});
