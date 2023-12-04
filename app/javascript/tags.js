document.addEventListener('turbo:load', function() {
  const inputTag = document.getElementById('inputTag');
  const tagContainer = document.getElementById('TagContainer');
  const addButton = document.getElementById('addTagButton');
  let tagIndex = 0; // タグのインデックスを管理する変数

  // タグを追加する関数
  function addTag() {
    const inputText = inputTag.value;
    if (inputText) {
      createBadge(inputText);
      createHiddenInput(inputText, tagIndex);

      // インデックスを増やす
      tagIndex++;

      // 入力フィールドをクリア
      inputTag.value = '';
    }
  }

  // タグを表示する関数
  function createBadge(text) {
    const badge = document.createElement('div');
    badge.textContent = text;
    badge.classList.add('badge');
    tagContainer.appendChild(badge);
  }

  // 隠しフィールドを追加する関数
  function createHiddenInput(value, index) {
    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = `post[tags_attributes][${index}][name]`;
    hiddenInput.value = value;
    document.querySelector('form').appendChild(hiddenInput);

    // タグのidフィールド（新しいタグの場合は値なし）
    const hiddenIdInput = document.createElement('input');
    hiddenIdInput.type = 'hidden';
    hiddenIdInput.name = `post[tags_attributes][${index}][id]`;
    document.querySelector('form').appendChild(hiddenIdInput);
  }

  // エンターかボタンクリックでタグを追加する関数
  function setupTagInputHandlers() {
    // 入力フィールドにユーザーが入力したとき(エンターキー押下時の処理)
    if (inputTag) {
      inputTag.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
          event.preventDefault();
          addTag();
        }
      });
    }

    // タグ追加ボタンクリック時の処理
    if (addButton) {
      addButton.addEventListener('click', addTag);
    }
  }

  // タグ追加実行
  setupTagInputHandlers();
});
