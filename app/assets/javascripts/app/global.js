$(document).on('turbolinks:load', function() {
  Waves.displayEffect(); // Initialize buttons wave effects
  $(".button-collapse").sideNav(); // Initialize collapse button
  $('select').material_select();

});


import './flashes';
import './parallax';
import './chart';
import './invoice';


