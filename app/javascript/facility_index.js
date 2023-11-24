document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.prefecture-row').forEach(function(row) {
    row.addEventListener('click', function() {
      var prefectureId = this.dataset.prefectureId;
      var facilityRow = document.querySelector('.facility-row[data-prefecture-id="' + prefectureId + '"]');
      var isHidden = facilityRow.style.display === 'none';

      // 施設リストの表示/非表示の切り替え
      facilityRow.style.display = isHidden ? 'table-row' : 'none';

      // アイコンの切り替え
      var icon = this.querySelector('.prefecture-icon');
      icon.textContent = isHidden ? '▽' : '△';
    });
  });
});
