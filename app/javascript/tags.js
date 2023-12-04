document.addEventListener('turbo:load', function() {
  const inputTag = document.getElementById('input-tag');
  const tagContainer = document.getElementById('tag-container');
  const addButton = document.getElementById('add-tag-button');
  let tagIndex = 0; // タグのインデックスを管理する変数

  // タグを追加する関数
  function addTag() {
    const inputText = inputTag.value;
    if (inputText) {
      createBadge(inputText, tagIndex);
      createHiddenInput(inputText, tagIndex);

      // インデックスを増やす
      tagIndex++;

      // 入力フィールドをクリア
      inputTag.value = '';
    }
  }

  // タグを削除する関数
  function deleteTag(badge, index) {
    // タグを削除
    badge.remove();
    // 対応するname,idフィールドを空欄にする(コントローラーで空欄は除外されるため)
    const nameInput = document.querySelector(`input[name='post[tags_attributes][${index}][name]']`);
    const idInput = document.querySelector(`input[name='post[tags_attributes][${index}][id]']`);
    if (nameInput) nameInput.value = '';
    if (idInput) idInput.value = '';
  }

  // タグを表示する関数
  function createBadge(text, index) {
    const badge = document.createElement('div');
    badge.textContent = text;
    badge.classList.add('badge');

    // 削除ボタンを追加
    const deleteBtn = document.createElement('button');
    deleteBtn.textContent = '✕'; // バツマーク
    deleteBtn.onclick = function() {
      deleteTag(badge, index);
    };

    badge.appendChild(deleteBtn);
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
