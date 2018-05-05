import Tesseract from 'tesseract.js/dist/tesseract.js'


document.getElementById('bill_image').onchange = function(i) {
  document.getElementById('image_loader').classList.remove('fade-in')
  Tesseract.recognize(this.files[0])
  .then(function(result){
    console.log('result is: ', result)
    document.getElementById('image_loader').classList.add('fade-in')

    document.getElementById('image_result').innerHTML = result.html
  })
};
