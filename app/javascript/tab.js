document.addEventListener('turbo:load', function() {

  // タブがクリックされたときの処理
  $('.tab_change').on('click', function (e) {
    e.preventDefault(); // リンクのデフォルトの動作を無効にする

    // クリックされたタブのhref属性から対応するコンテンツのIDを取得
    var targetId = $(this).attr('data-bs-target');

    // すべてのコンテンツを非表示にし、クリックされたタブに関連するコンテンツを表示
    $('.tab-pane').removeClass('show active');
    $(targetId).addClass('show active');

  });

});