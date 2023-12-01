document.addEventListener('turbo:load', function() {
  const addButton = document.getElementById('addTagButton');
  if (addButton) {
    addButton.addEventListener('click', function() {
      const inputText = document.getElementById('inputTag').value;

      // 入力されたテキストをタグとして表示
      if(inputText) {
        const newBadge = document.createElement('div');
        newBadge.textContent = inputText;
        newBadge.classList.add('badge');

        document.getElementById('TagContainer').appendChild(newBadge);

        // 隠しフィールドを追加
        const hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'post[tags_attributes][][name]');
        hiddenInput.value = inputText;
        document.querySelector('form').appendChild(hiddenInput);

        // 入力フィールドをクリア
        document.getElementById('inputTag').value = '';
      }

    });
  }
});
