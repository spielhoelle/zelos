const BODY_ELEMENT = document.getElementsByTagName('body')[0];
const FLASH = document.querySelectorAll(".flash-alert")

if (document.querySelectorAll(".flash-alert").length > 0) {
  BODY_ELEMENT.addEventListener('click', (event) => {
    for (let i = 0; i < FLASH.length; i++) {
      setTimeout(function() {
        FLASH[i].classList.remove("in");
      }, 100)
    }
  });
  for (let i = 0; i < FLASH.length; i++) {
    setTimeout(function() {
      FLASH[i].classList.remove("in");
    }, 2000)
  }
}
