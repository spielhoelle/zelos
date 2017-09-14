$(document).ready(function(){
  $('.parallax').parallax();

});
var options = [
  { selector:".scrollfire1", offset: 100, callback: function(el){fadeIn($(el))}},
  { selector:".scrollfire2", offset: 100, callback: function(el){fadeIn($(el))}},
  { selector:".scrollfire3", offset: 300, callback: function(el){fadeIn($(el))}},
  { selector:".scrollfire4", offset: 300, callback: function(el){fadeIn($(el))}}];
$(function(){Materialize.scrollFire(options)})
//var options = [{ selector:".scrollfire2", offset: 100, callback: function(e){
//console.log(e)
//$(".scrollfire2 > *").addClass('visible')
//}}];
//$(function(){Materialize.scrollFire(options)})
function fadeIn(el) {
  console.log(el)
  el.children().addClass('visible')
}

//var options = [
  //{selector: '#staggered-test', offset: 50, callback: function(el) { Materialize.toast("This is our ScrollFire Demo!", 1500 ); } },
  //{selector: '#staggered-test', offset: 205, callback: function(el) { Materialize.toast("Please continue scrolling!", 1500 ); } },
  //{selector: '#staggered-test', offset: 400, callback: function(el) { Materialize.showStaggeredList($(el)); } },
  //{selector: '#image-test', offset: 500, callback: function(el) { Materialize.fadeInImage($(el)); } } ];
//Materialize.scrollFire(options);

