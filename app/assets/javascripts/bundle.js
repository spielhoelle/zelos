/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(1);


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(2);

__webpack_require__(3);

__webpack_require__(4);

__webpack_require__(5);

$(document).on('turbolinks:load', function () {
  Waves.displayEffect(); // Initialize buttons wave effects
  $(".button-collapse").sideNav(); // Initialize collapse button
  $('select').material_select();
  $('.materialboxed').materialbox();
});

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var BODY_ELEMENT = document.getElementsByTagName('body')[0];
var FLASH = document.querySelectorAll(".flash-alert");

if (document.querySelectorAll(".flash-alert").length > 0) {
  BODY_ELEMENT.addEventListener('click', function (event) {
    var _loop = function _loop(i) {
      setTimeout(function () {
        FLASH[i].classList.remove("in");
      }, 100);
    };

    for (var i = 0; i < FLASH.length; i++) {
      _loop(i);
    }
  });

  var _loop2 = function _loop2(i) {
    setTimeout(function () {
      FLASH[i].classList.remove("in");
    }, 2000);
  };

  for (var i = 0; i < FLASH.length; i++) {
    _loop2(i);
  }
}

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


$(document).ready(function () {
  $('.parallax').parallax();
});
var options = [{ selector: ".scrollfire1", offset: 100, callback: function callback(el) {
    fadeIn($(el));
  } }, { selector: ".scrollfire2", offset: 100, callback: function callback(el) {
    fadeIn($(el));
  } }, { selector: ".scrollfire3", offset: 300, callback: function callback(el) {
    fadeIn($(el));
  } }, { selector: ".scrollfire4", offset: 300, callback: function callback(el) {
    fadeIn($(el));
  } }];
$(function () {
  Materialize.scrollFire(options);
});
function fadeIn(el) {
  el.children().addClass('visible');
}

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
// google.charts.load('current', {
//   packages: ['corechart', 'bar']
// });
// $(document).on('turbolinks:load', function() {
//   if (document.getElementById('chart_div') !== null || document.getElementById('chart_div') !== undefined) {
//     google.charts.setOnLoadCallback(drawMaterial);
//   }
// })
//
// function drawMaterial() {
//   var settings = {
//     "async": true,
//     "crossDomain": true,
//     "url": window.location.origin + "/admin/entries?format=json",
//     "method": "GET",
//   }
//
//   $.ajax(settings).done(function(response) {
//     var data = google.visualization.arrayToDataTable(response);
//
//     var materialOptions = {
//       chart: {
//         title: 'Recent Invoices'
//       },
//       hAxis: {
//         title: 'EUR',
//         minValue: 0,
//       },
//       vAxis: {
//         title: 'Company'
//       },
//       bars: 'horizontal',
//       legend: { position: 'none' }
//     };
//     var materialChart = new google.charts.Bar(document.getElementById('chart_div'));
//     materialChart.draw(data, materialOptions);
//   });
// }


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var sel = document.getElementById('entry_is_offer');
if (sel) {
  sel.onchange = function () {
    if (this.checked == true) {
      $(".collapsible-header").addClass("active");
      $(".collapsible").collapsible({ accordion: false });
      $('#invoice_type').text("Offer");
    } else {
      $(".collapsible-header").removeClass("active");
      $(".collapsible").collapsible({ accordion: true });
      $('#invoice_type').text("Invoice");
    }
  };
}
$(function () {
  $('.sortable').railsSortable({
    placeholder: "ui-state-highlight"

  });
  $('.nested_index').each(function () {
    this.parentElement.id = "Item_" + this.innerText;
  });
});

$(document).on('click', '.note-part', function () {
  $('#entry_notes').val($('#entry_notes').text() + "\n" + this.dataset.value);
  $('#entry_notes').prev().addClass('active');
});

$(document).on("fields_added.nested_form_fields", function (event, param) {
  $('.nested_entry_items').last().find('input:first').focus();
});

$(document).on("fields_added.nested_form_fields", function (event, param) {
  $('.nested_entry_items').last().find('input:first').focus();
});

$(document).ready(function () {
  // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
  $('.modal').modal({
    dismissible: true, // Modal can be dismissed by clicking outside of the modal
    opacity: .5, // Opacity of modal background
    inDuration: 300, // Transition in duration
    outDuration: 200, // Transition out duration
    startingTop: '4%', // Starting top style attribute
    endingTop: '10%', // Ending top style attribute
    ready: function ready(modal, trigger) {
      // Callback for Modal open. Modal and trigger parameters available.
      $('#user_email').focus().click();
    },
    complete: function complete() {} // Callback for Modal close
  });
});
$(document).on('turbolinks:load', function () {
  if ($('body').hasClass('customers') || $('body').hasClass('entries-edit') || $('body').hasClass('entries-new')) {
    $(function () {
      $.ajax({
        dataType: "json",
        url: "/admin/customers",
        type: "GET",
        success: function success(data) {
          var result = {};
          var address_result = {};
          data.forEach(function (e, i) {
            result[e.name] = null;
            address_result[e.name] = [e.address, e.company, e.id];
          });
          $('.autocomplete').autocomplete({
            data: result,
            limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function onAutocomplete(val) {
              if ($('body').hasClass('customers-index')) {
                $('form#search-form').submit();
              }
              var id = $('#entry_customer_attributes_id');
              var address = $('#entry_customer_attributes_address');
              var company = $('#entry_customer_attributes_company');
              id.val(address_result[val][2]);
              address.val(address_result[val][0]).prop('readonly', true);;
              company.val(address_result[val][1]).prop('readonly', true);;
              address.prev().addClass('active');
              company.prev().addClass('active');
            },
            minLength: 0 // The minimum length of the input for the autocomplete to start. Default: 1.
          });
        }
      });
    });
    $('.autocomplete').on("change", function (e) {
      var value = $(e.currentTarget).val(); // ...and using it here
      if (value === "") {
        var text_field = $('#entry_customer_attributes_address, #entry_customer_attributes_company, #entry_customer_attributes_id');
        text_field.val("").prop('readonly', false);
        text_field.prev().removeClass('active');
      }
    });
  } else if ($('body').hasClass('entries-index')) {

    $(function () {
      $.ajax({
        dataType: "json",
        url: "/admin/entries",
        type: "GET",
        success: function success(data) {
          var result = {};
          var address_result = {};
          data.forEach(function (e, i) {
            result[e.title] = null;
            address_result[e.title] = [e.title, e.id];
          });
          $('.autocomplete').autocomplete({
            data: result,
            limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function onAutocomplete(val) {
              $('form#search-form').submit();
            },
            minLength: 0 // The minimum length of the input for the autocomplete to start. Default: 1.
          });
        }
      });
    });
  }
});

/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map