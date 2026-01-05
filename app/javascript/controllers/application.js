import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }



document.addEventListener("turbo:load", () => {
    const flash = document.querySelector(".flash-overlay");
    if (flash) {
      setTimeout(() => {
        flash.style.opacity = "0";
        setTimeout(() => flash.remove(), 400);
      }, 3000);
    }
  });
  