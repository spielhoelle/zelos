import Tesseract from 'tesseract.js/dist/tesseract.js'


const bboxToStyle = function(bbox_str) {
  let style = ""
  var element = bbox_str.firstElementChild !== null ? bbox_str.firstElementChild : bbox_str
  console.log(element);
  element.style = "border: 1px solid white"
  if(element.innerText.match(/[0-9]/g)){
    element.style = "border: 1px solid red"
    style += "color: red !important; "
  }
  var arr = bbox_str.title.split(" ").map(i => i.replace(/[^0-9]/g, ' ').replace(" ", ''));
  var box = document.querySelector(".ocr_page").title.replace(/[^0-9]/g, ' ').split(' ').filter(function(n){ return n != "" && n != 0 })
  var multiplicator = document.querySelector(".material-placeholder").offsetWidth / box[0];
  console.log(box);
  var left_pos = "left:"+arr[1] * multiplicator +"px; ";
  var top_pos = "top:"+arr[2] * multiplicator +"px; ";
  var right_pos = "right:"+arr[3] * multiplicator +"px; ";
  var bottom_pos = "bottom:"+arr[4] * multiplicator +"px; ";
  return style + left_pos + top_pos + right_pos + bottom_pos + "position: absolute; ";
};
if (document.getElementById('bill_image')){
  document.getElementById('bill_image').onchange = function(i) {


    if (this.files && this.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        var img = document.createElement('img')
        img.src = e.target.result
        document.querySelector('.materialboxed').src = e.target.result
      }
      reader.readAsDataURL(this.files[0]);
    }


    document.getElementById("image_text").classList.add("fade-in")
    document.getElementById('image_loader').classList.remove('fade-in')
    // if we know our image is of spanish words without the letter 'e':
    Tesseract.recognize(this.files[0], {
      lang: 'deu',
      // tessedit_char_blacklist: 'e'
    })
    .progress(function(message){
      console.log('progress is: ', message)
      if(message.status === "recognizing text"){
        document.getElementById('image_loader').querySelector('.determinate').style.width = message.progress * 100 + "%"
      }
    })
    .then(function(result){
      console.log(result)
      document.getElementById('image_loader').classList.add('fade-in')
      document.querySelector(".material-placeholder").classList.add("half-transparent")
      document.getElementById('image_result').innerHTML = result.html
      $(".ocrx_word").attr('style', function() {
        return bboxToStyle(this);
      });
    })
    // Tesseract.recognize(this.files[0])
    // .then(function(result){
    //   console.log('result is: ', result)
    //   document.getElementById('image_loader').classList.add('fade-in')
    //
    //   document.getElementById('image_result').innerHTML = result.html
    // })
  };
}
