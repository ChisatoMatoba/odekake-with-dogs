document.addEventListener('DOMContentLoaded', function () {
  var modalClicks = document.querySelectorAll('.modal_click');
  modalClicks.forEach(function (modalClick) {
    modalClick.addEventListener('click', function (e) {
      e.preventDefault(); // リンクのデフォルトの動作を無効にする
      console.log('クリックイベントがトリガーされました。'); // デバッグ用のログ

      // クリックされた画像のdata-post-id属性から対応する投稿のIDを取得
      var postId = this.getAttribute('data-post-id');

      // 対応するモーダルを表示
      var modalElement = document.getElementById('tOiMnQnqDw-modal-' + postId);
      var modal = new bootstrap.Modal(modalElement);

      // モーダルを表示する前にキャルーセルを初期化
      // var carouselElement = modalElement.querySelector('#lb-tOiMnQnqDw-' + postId);
      // var carousel = new bootstrap.Carousel(carouselElement);

      console.log(postId);
      console.log(modal);
      // console.log(carousel);

      modal.show();

      // モーダルを閉じるボタンのクリックイベントを削除してから再登録
      var closeModalButtons = modalElement.querySelectorAll('.close-modal');
      closeModalButtons.forEach(function (closeButton) {
        closeButton.removeEventListener('click', closeModalHandler); // クリックイベントを削除
        closeButton.addEventListener('click', closeModalHandler.bind(modal)); // クリックイベントを再登録
      });
    });
  });

  // モーダルを閉じるボタンをクリックしたときの処理
  function closeModalHandler() {
    this.hide(); // モーダルを閉じる
    console.log("モーダル閉じました");
  }
});



