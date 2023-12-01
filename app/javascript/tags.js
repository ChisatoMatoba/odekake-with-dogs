document.addEventListener('turbo:load', function() {
  const inputTag = document.getElementById('inputTag');
  const tagContainer = document.getElementById('TagContainer');

  // タグを追加する関数
  function addTag() {
    const inputText = inputTag.value;

    if(inputText) {
      // タグを表示
      const newBadge = document.createElement('div');
      newBadge.textContent = inputText;
      newBadge.classList.add('badge');
      tagContainer.appendChild(newBadge);

      // 隠しフィールドを追加
      const hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'post[tags_attributes][][name]');
      hiddenInput.value = inputText;
      document.querySelector('form').appendChild(hiddenInput);

      // 入力フィールドをクリア
      inputTag.value = '';
    }
  }

  // 入力フィールドにユーザーが入力したとき
  if (inputTag) {
    inputTag.addEventListener('keypress', function(event) {
      // エンターキー押下時の処理
      if (event.key === 'Enter') {
        event.preventDefault(); // フォームの送信を防ぐ
        addTag();
      }

      // ボタンクリック時の処理
      const addButton = document.getElementById('addTagButton');
      if (addButton) {
        addButton.addEventListener('click', addTag);
      }
    });
  }
});
