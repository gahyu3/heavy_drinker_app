import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="count"
export default class extends Controller {
  static targets = ["count","hoho"];
  connect() {
    console.log("Connect count");
    this.updateCount();
  }

}

 