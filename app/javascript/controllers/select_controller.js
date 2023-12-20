import { Controller } from "@hotwired/stimulus";
import "select2";

export default class extends Controller {
  connect() {
    $(this.element).find('.select2').select2();
    $('.multis').select2({
      placeholder: "Select days of the week",
      allowClear: true
    });
  }
}
