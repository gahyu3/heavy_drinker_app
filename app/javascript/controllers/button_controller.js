import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {
  static targets = ["output"];
  connect() {
    console.log("dodo");
  }

  plus() {
    console.log("plus method called");
    this.outputTarget.value = parseInt(this.outputTarget.value || 0, 10) + 1;
  }

  minus() {
    console.log("minus method called");
    this.outputTarget.value = parseInt(this.outputTarget.value || 0, 10) - 1;
  }

}
