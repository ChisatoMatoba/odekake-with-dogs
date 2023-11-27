// 行をクリックした時の動作
function handleRowClick() {
  const prefectureId = this.dataset.prefectureId;
  const facilityRow = document.querySelector('.facility-row[data-prefecture-id="' + prefectureId + '"]');
  const isHidden = facilityRow.style.display === 'none';

  // 施設リストの表示/非表示の切り替え
  facilityRow.style.display = isHidden? 'table-row' : 'none';

  // アイコンの切り替え
  const icon = this.querySelector('.prefecture-icon');
  icon.classList.toggle('bi-chevron-down');
  icon.classList.toggle('bi-chevron-up');
}

// まとめ
function handlePrefectureRowClick() {
  document.querySelectorAll('.prefecture-row').forEach(function(row) {
    row.addEventListener('click', handleRowClick);
  });
}

// ページロード時にイベントリスナー設定
document.addEventListener('turbo:load', handlePrefectureRowClick);
