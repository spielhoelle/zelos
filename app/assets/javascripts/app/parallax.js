$(document).ready(function(){
  $('.parallax').parallax();

});
var options = [
  { selector:".scrollfire1", offset: 100, callback: function(el){fadeIn($(el))}},
  { selector:".scrollfire2", offset: 100, callback: function(el){fadeIn($(el))}},
  { selector:".scrollfire3", offset: 300, callback: function(el){fadeIn($(el))}},
  { selector:".scrollfire4", offset: 300, callback: function(el){fadeIn($(el))}}];
$(function(){Materialize.scrollFire(options)})
function fadeIn(el) {
  el.children().addClass('visible')
}

