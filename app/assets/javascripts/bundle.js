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

__webpack_require__(6);

$(document).on('turbolinks:load', function () {
  Waves.displayEffect(); // Initialize buttons wave effects
  $(".button-collapse").sidenav(); // Initialize collapse button
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

function fadeIn(el) {
  el.children().addClass('visible');
}
$(document).ready(function () {
  $('.fixed-action-btn').floatingActionButton();
});

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


var elems = document.querySelectorAll(".collapsible");
var instances = M.Collapsible.init(elems);
var ca_ching = document.getElementById("ca_ching");
if (ca_ching) {
  var uri = window.location.toString();
  if (uri.indexOf("?") > 0) {
    ca_ching.play();
    var clean_uri = uri.substring(0, uri.indexOf("?"));
    window.history.replaceState({}, document.title, clean_uri);
  }
}
document.addEventListener("DOMContentLoaded", function () {
  var sel = document.getElementById("entry_is_offer");
  if (sel) {
    sel.onchange = function () {
      var _iteratorNormalCompletion = true;
      var _didIteratorError = false;
      var _iteratorError = undefined;

      try {
        for (var _iterator = instances[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
          var instance = _step.value;

          if (instance.el.dataset.name == this.id) {
            if (this.checked == true) {
              console.log("instance.el.dataset.name == this.id", instance.el.dataset.name, this.id);
              instance.open();
            } else {
              instance.close();
            }
          }
        }
      } catch (err) {
        _didIteratorError = true;
        _iteratorError = err;
      } finally {
        try {
          if (!_iteratorNormalCompletion && _iterator.return) {
            _iterator.return();
          }
        } finally {
          if (_didIteratorError) {
            throw _iteratorError;
          }
        }
      }
    };
  }
  var sumTime = document.getElementById("entry_sum_time");
  if (sumTime) {
    sumTime.onchange = function () {
      if (this.checked == true) {
        document.getElementById("entry_delivery_date").disabled = false;
        var _iteratorNormalCompletion2 = true;
        var _didIteratorError2 = false;
        var _iteratorError2 = undefined;

        try {
          for (var _iterator2 = document.querySelectorAll("fieldset .d-flex > .input-field:first-child input")[Symbol.iterator](), _step2; !(_iteratorNormalCompletion2 = (_step2 = _iterator2.next()).done); _iteratorNormalCompletion2 = true) {
            var item = _step2.value;

            item.disabled = true;
          }
        } catch (err) {
          _didIteratorError2 = true;
          _iteratorError2 = err;
        } finally {
          try {
            if (!_iteratorNormalCompletion2 && _iterator2.return) {
              _iterator2.return();
            }
          } finally {
            if (_didIteratorError2) {
              throw _iteratorError2;
            }
          }
        }
      } else {
        document.getElementById("entry_delivery_date").disabled = true;
        var _iteratorNormalCompletion3 = true;
        var _didIteratorError3 = false;
        var _iteratorError3 = undefined;

        try {
          for (var _iterator3 = document.querySelectorAll("fieldset .d-flex > .input-field:first-child input")[Symbol.iterator](), _step3; !(_iteratorNormalCompletion3 = (_step3 = _iterator3.next()).done); _iteratorNormalCompletion3 = true) {
            var _item = _step3.value;

            _item.disabled = false;
          }
        } catch (err) {
          _didIteratorError3 = true;
          _iteratorError3 = err;
        } finally {
          try {
            if (!_iteratorNormalCompletion3 && _iterator3.return) {
              _iterator3.return();
            }
          } finally {
            if (_didIteratorError3) {
              throw _iteratorError3;
            }
          }
        }
      }
    };
  }
});

$(function () {
  $(".sortable").railsSortable({
    placeholder: "ui-state-highlight"
  });
  $(".nested_index").each(function () {
    this.parentElement.id = "Item_" + this.innerText;
  });
});

$(document).on("click", ".note-part", function () {
  $("#entry_notes").val($("#entry_notes").text() + "\n" + this.dataset.value);
  $("#entry_notes").prev().addClass("active");
});

$(document).on("fields_added.nested_form_fields", function (event, param) {
  $(".nested_entry_items").last().find("input:first").focus();
});

$(document).on("fields_added.nested_form_fields", function (event, param) {
  $(".nested_entry_items").last().find("input:first").focus();
});

$(document).ready(function () {
  // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
  $(".modal").modal({
    dismissible: true, // Modal can be dismissed by clicking outside of the modal
    opacity: 0.5, // Opacity of modal background
    inDuration: 300, // Transition in duration
    outDuration: 200, // Transition out duration
    startingTop: "4%", // Starting top style attribute
    endingTop: "10%", // Ending top style attribute
    ready: function ready(modal, trigger) {
      // Callback for Modal open. Modal and trigger parameters available.
      $("#user_email").focus().click();
    },
    complete: function complete() {} // Callback for Modal close
  });
});
$(document).on("turbolinks:load", function () {
  if ($("body").hasClass("customers") || $("body").hasClass("entries-edit") || $("body").hasClass("entries-new")) {
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
          $(".autocomplete").autocomplete({
            data: result,
            limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function onAutocomplete(val) {
              if ($("body").hasClass("customers-index")) {
                $("form#search-form").submit();
              }
              var id = $("#entry_customer_attributes_id");
              var address = $("#entry_customer_attributes_address");
              var company = $("#entry_customer_attributes_company");
              id.val(address_result[val][2]);
              address.val(address_result[val][0]).prop("readonly", true);
              company.val(address_result[val][1]).prop("readonly", true);
              address.prev().addClass("active");
              company.prev().addClass("active");
            },
            minLength: 0 // The minimum length of the input for the autocomplete to start. Default: 1.
          });
        }
      });
    });
    $(".autocomplete").on("change", function (e) {
      var value = $(e.currentTarget).val(); // ...and using it here
      if (value === "") {
        var text_field = $("#entry_customer_attributes_address, #entry_customer_attributes_company, #entry_customer_attributes_id");
        text_field.val("").prop("readonly", false);
        text_field.prev().removeClass("active");
      }
    });
  } else if ($("body").hasClass("entries-index")) {
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
          $(".autocomplete").autocomplete({
            data: result,
            limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function onAutocomplete(val) {
              $("form#search-form").submit();
            },
            minLength: 0 // The minimum length of the input for the autocomplete to start. Default: 1.
          });
        }
      });
    });
  }
});

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _tesseract = __webpack_require__(7);

var _tesseract2 = _interopRequireDefault(_tesseract);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var bboxToStyle = function bboxToStyle(bbox_str) {
  var style = "";
  var element = bbox_str.firstElementChild !== null ? bbox_str.firstElementChild : bbox_str;
  console.log(element);
  element.style = "border: 1px solid white";
  if (element.innerText.match(/[0-9]/g)) {
    element.style = "border: 1px solid red";
    style += "color: red !important; ";
  }
  var arr = bbox_str.title.split(" ").map(function (i) {
    return i.replace(/[^0-9]/g, ' ').replace(" ", '');
  });
  var box = document.querySelector(".ocr_page").title.replace(/[^0-9]/g, ' ').split(' ').filter(function (n) {
    return n != "" && n != 0;
  });
  var multiplicator = document.querySelector(".material-placeholder").offsetWidth / box[0];
  console.log(box);
  var left_pos = "left:" + arr[1] * multiplicator + "px; ";
  var top_pos = "top:" + arr[2] * multiplicator + "px; ";
  var right_pos = "right:" + arr[3] * multiplicator + "px; ";
  var bottom_pos = "bottom:" + arr[4] * multiplicator + "px; ";
  return style + left_pos + top_pos + right_pos + bottom_pos + "position: absolute; ";
};
if (document.getElementById('bill_image')) {
  document.getElementById('bill_image').onchange = function (i) {

    if (this.files && this.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        var img = document.createElement('img');
        img.src = e.target.result;
        document.querySelector('.materialboxed').src = e.target.result;
      };
      reader.readAsDataURL(this.files[0]);
    }

    document.getElementById("image_text").classList.add("fade-in");
    document.getElementById('image_loader').classList.remove('fade-in');
    // if we know our image is of spanish words without the letter 'e':
    _tesseract2.default.recognize(this.files[0], {
      lang: 'deu'
      // tessedit_char_blacklist: 'e'
    }).progress(function (message) {
      console.log('progress is: ', message);
      if (message.status === "recognizing text") {
        document.getElementById('image_loader').querySelector('.determinate').style.width = message.progress * 100 + "%";
      }
    }).then(function (result) {
      console.log(result);
      document.getElementById('image_loader').classList.add('fade-in');
      document.querySelector(".material-placeholder").classList.add("half-transparent");
      document.getElementById('image_result').innerHTML = result.html;
      $(".ocrx_word").attr('style', function () {
        return bboxToStyle(this);
      });
    });
    // Tesseract.recognize(this.files[0])
    // .then(function(result){
    //   console.log('result is: ', result)
    //   document.getElementById('image_loader').classList.add('fade-in')
    //
    //   document.getElementById('image_result').innerHTML = result.html
    // })
  };
}

/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

var require;var require;(function(f){if(true){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.Tesseract = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return require(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// shim for using process in browser
var process = module.exports = {};

// cached from whatever global is present so that test runners that stub it
// don't break things.  But we need to wrap it in a try catch in case it is
// wrapped in strict mode code which doesn't define any globals.  It's inside a
// function because try/catches deoptimize in certain engines.

var cachedSetTimeout;
var cachedClearTimeout;

function defaultSetTimout() {
    throw new Error('setTimeout has not been defined');
}
function defaultClearTimeout () {
    throw new Error('clearTimeout has not been defined');
}
(function () {
    try {
        if (typeof setTimeout === 'function') {
            cachedSetTimeout = setTimeout;
        } else {
            cachedSetTimeout = defaultSetTimout;
        }
    } catch (e) {
        cachedSetTimeout = defaultSetTimout;
    }
    try {
        if (typeof clearTimeout === 'function') {
            cachedClearTimeout = clearTimeout;
        } else {
            cachedClearTimeout = defaultClearTimeout;
        }
    } catch (e) {
        cachedClearTimeout = defaultClearTimeout;
    }
} ())
function runTimeout(fun) {
    if (cachedSetTimeout === setTimeout) {
        //normal enviroments in sane situations
        return setTimeout(fun, 0);
    }
    // if setTimeout wasn't available but was latter defined
    if ((cachedSetTimeout === defaultSetTimout || !cachedSetTimeout) && setTimeout) {
        cachedSetTimeout = setTimeout;
        return setTimeout(fun, 0);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedSetTimeout(fun, 0);
    } catch(e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't trust the global object when called normally
            return cachedSetTimeout.call(null, fun, 0);
        } catch(e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error
            return cachedSetTimeout.call(this, fun, 0);
        }
    }


}
function runClearTimeout(marker) {
    if (cachedClearTimeout === clearTimeout) {
        //normal enviroments in sane situations
        return clearTimeout(marker);
    }
    // if clearTimeout wasn't available but was latter defined
    if ((cachedClearTimeout === defaultClearTimeout || !cachedClearTimeout) && clearTimeout) {
        cachedClearTimeout = clearTimeout;
        return clearTimeout(marker);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedClearTimeout(marker);
    } catch (e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't  trust the global object when called normally
            return cachedClearTimeout.call(null, marker);
        } catch (e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error.
            // Some versions of I.E. have different rules for clearTimeout vs setTimeout
            return cachedClearTimeout.call(this, marker);
        }
    }



}
var queue = [];
var draining = false;
var currentQueue;
var queueIndex = -1;

function cleanUpNextTick() {
    if (!draining || !currentQueue) {
        return;
    }
    draining = false;
    if (currentQueue.length) {
        queue = currentQueue.concat(queue);
    } else {
        queueIndex = -1;
    }
    if (queue.length) {
        drainQueue();
    }
}

function drainQueue() {
    if (draining) {
        return;
    }
    var timeout = runTimeout(cleanUpNextTick);
    draining = true;

    var len = queue.length;
    while(len) {
        currentQueue = queue;
        queue = [];
        while (++queueIndex < len) {
            if (currentQueue) {
                currentQueue[queueIndex].run();
            }
        }
        queueIndex = -1;
        len = queue.length;
    }
    currentQueue = null;
    draining = false;
    runClearTimeout(timeout);
}

process.nextTick = function (fun) {
    var args = new Array(arguments.length - 1);
    if (arguments.length > 1) {
        for (var i = 1; i < arguments.length; i++) {
            args[i - 1] = arguments[i];
        }
    }
    queue.push(new Item(fun, args));
    if (queue.length === 1 && !draining) {
        runTimeout(drainQueue);
    }
};

// v8 likes predictible objects
function Item(fun, array) {
    this.fun = fun;
    this.array = array;
}
Item.prototype.run = function () {
    this.fun.apply(null, this.array);
};
process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];
process.version = ''; // empty string to avoid regexp issues
process.versions = {};

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;
process.prependListener = noop;
process.prependOnceListener = noop;

process.listeners = function (name) { return [] }

process.binding = function (name) {
    throw new Error('process.binding is not supported');
};

process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};
process.umask = function() { return 0; };

},{}],2:[function(require,module,exports){
module.exports={
  "name": "tesseract.js",
  "version": "1.0.13",
  "description": "Pure Javascript Multilingual OCR",
  "main": "src/index.js",
  "scripts": {
    "start": "concurrently --kill-others \"watchify src/index.js  -t [ envify --NODE_ENV development ] -t [ babelify --presets [ es2015 ] ] -o dist/tesseract.dev.js --standalone Tesseract\" \"watchify src/browser/worker.js  -t [ envify --NODE_ENV development ] -t [ babelify --presets [ es2015 ] ] -o dist/worker.dev.js\" \"http-server -p 7355\"",
    "build": "browserify src/index.js -t [ babelify --presets [ es2015 ] ] -o dist/tesseract.js --standalone Tesseract && browserify src/browser/worker.js -t [ babelify --presets [ es2015 ] ] -o dist/worker.js && uglifyjs dist/tesseract.js --source-map -o dist/tesseract.min.js && uglifyjs dist/worker.js --source-map -o dist/worker.min.js",
    "release": "npm run build && git commit -am 'new release' && git push && git tag `jq -r '.version' package.json` && git push origin --tags && npm publish"
  },
  "browser": {
    "./src/node/index.js": "./src/browser/index.js"
  },
  "author": "",
  "license": "Apache-2.0",
  "devDependencies": {
    "babel-preset-es2015": "^6.16.0",
    "babelify": "^7.3.0",
    "browserify": "^13.1.0",
    "concurrently": "^3.1.0",
    "envify": "^3.4.1",
    "http-server": "^0.9.0",
    "pako": "^1.0.3",
    "uglify-js": "^3.4.9",
    "watchify": "^3.7.0"
  },
  "dependencies": {
    "file-type": "^3.8.0",
    "isomorphic-fetch": "^2.2.1",
    "is-url": "1.2.2",
    "jpeg-js": "^0.2.0",
    "level-js": "^2.2.4",
    "node-fetch": "^1.6.3",
    "object-assign": "^4.1.0",
    "png.js": "^0.2.1",
    "tesseract.js-core": "^1.0.2"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/naptha/tesseract.js.git"
  },
  "bugs": {
    "url": "https://github.com/naptha/tesseract.js/issues"
  },
  "homepage": "https://github.com/naptha/tesseract.js"
}

},{}],3:[function(require,module,exports){
(function (process){
'use strict';

var defaultOptions = {
    // workerPath: 'https://cdn.jsdelivr.net/gh/naptha/tesseract.js@0.2.0/dist/worker.js',
    corePath: 'https://cdn.jsdelivr.net/gh/naptha/tesseract.js-core@0.1.0/index.js',
    langPath: 'https://tessdata.projectnaptha.com/3.02/'
};

if (process.env.NODE_ENV === "development") {
    console.debug('Using Development Configuration');
    defaultOptions.workerPath = location.protocol + '//' + location.host + '/dist/worker.dev.js?nocache=' + Math.random().toString(36).slice(3);
} else {
    var version = require('../../package.json').version;
    defaultOptions.workerPath = 'https://cdn.jsdelivr.net/gh/naptha/tesseract.js@' + version + '/dist/worker.js';
}

exports.defaultOptions = defaultOptions;

exports.spawnWorker = function spawnWorker(instance, workerOptions) {
    if (window.Blob && window.URL) {
        var blob = new Blob(['importScripts("' + workerOptions.workerPath + '");']);
        var worker = new Worker(window.URL.createObjectURL(blob));
    } else {
        var worker = new Worker(workerOptions.workerPath);
    }

    worker.onmessage = function (e) {
        var packet = e.data;
        instance._recv(packet);
    };
    return worker;
};

exports.terminateWorker = function (instance) {
    instance.worker.terminate();
};

exports.sendPacket = function sendPacket(instance, packet) {
    loadImage(packet.payload.image, function (img) {
        packet.payload.image = img;
        instance.worker.postMessage(packet);
    });
};

function loadImage(image, cb) {
    if (typeof image === 'string') {
        if (/^\#/.test(image)) {
            // element css selector
            return loadImage(document.querySelector(image), cb);
        } else if (/(blob|data)\:/.test(image)) {
            // data url
            var im = new Image();
            im.src = image;
            im.onload = function (e) {
                return loadImage(im, cb);
            };
            return;
        } else {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', image, true);
            xhr.responseType = "blob";
            xhr.onload = function (e) {
                return loadImage(xhr.response, cb);
            };
            xhr.onerror = function (e) {
                if (/^https?:\/\//.test(image) && !/^https:\/\/crossorigin.me/.test(image)) {
                    console.debug('Attempting to load image with CORS proxy');
                    loadImage('https://crossorigin.me/' + image, cb);
                }
            };
            xhr.send(null);
            return;
        }
    } else if (image instanceof File) {
        // files
        var fr = new FileReader();
        fr.onload = function (e) {
            return loadImage(fr.result, cb);
        };
        fr.readAsDataURL(image);
        return;
    } else if (image instanceof Blob) {
        return loadImage(URL.createObjectURL(image), cb);
    } else if (image.getContext) {
        // canvas element
        return loadImage(image.getContext('2d'), cb);
    } else if (image.tagName == "IMG" || image.tagName == "VIDEO") {
        // image element or video element
        var c = document.createElement('canvas');
        c.width = image.naturalWidth || image.videoWidth;
        c.height = image.naturalHeight || image.videoHeight;
        var ctx = c.getContext('2d');
        ctx.drawImage(image, 0, 0);
        return loadImage(ctx, cb);
    } else if (image.getImageData) {
        // canvas context
        var data = image.getImageData(0, 0, image.canvas.width, image.canvas.height);
        return loadImage(data, cb);
    } else {
        return cb(image);
    }
    throw new Error('Missing return in loadImage cascade');
}

}).call(this,require('_process'))
},{"../../package.json":2,"_process":1}],4:[function(require,module,exports){
"use strict";

// The result of dump.js is a big JSON tree
// which can be easily serialized (for instance
// to be sent from a webworker to the main app
// or through Node's IPC), but we want
// a (circular) DOM-like interface for walking
// through the data. 

module.exports = function circularize(page) {
    page.paragraphs = [];
    page.lines = [];
    page.words = [];
    page.symbols = [];

    page.blocks.forEach(function (block) {
        block.page = page;

        block.lines = [];
        block.words = [];
        block.symbols = [];

        block.paragraphs.forEach(function (para) {
            para.block = block;
            para.page = page;

            para.words = [];
            para.symbols = [];

            para.lines.forEach(function (line) {
                line.paragraph = para;
                line.block = block;
                line.page = page;

                line.symbols = [];

                line.words.forEach(function (word) {
                    word.line = line;
                    word.paragraph = para;
                    word.block = block;
                    word.page = page;
                    word.symbols.forEach(function (sym) {
                        sym.word = word;
                        sym.line = line;
                        sym.paragraph = para;
                        sym.block = block;
                        sym.page = page;

                        sym.line.symbols.push(sym);
                        sym.paragraph.symbols.push(sym);
                        sym.block.symbols.push(sym);
                        sym.page.symbols.push(sym);
                    });
                    word.paragraph.words.push(word);
                    word.block.words.push(word);
                    word.page.words.push(word);
                });
                line.block.lines.push(line);
                line.page.lines.push(line);
            });
            para.page.paragraphs.push(para);
        });
    });
    return page;
};

},{}],5:[function(require,module,exports){
'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var adapter = require('../node/index.js');

var jobCounter = 0;

module.exports = function () {
    function TesseractJob(instance) {
        _classCallCheck(this, TesseractJob);

        this.id = 'Job-' + ++jobCounter + '-' + Math.random().toString(16).slice(3, 8);

        this._instance = instance;
        this._resolve = [];
        this._reject = [];
        this._progress = [];
        this._finally = [];
    }

    _createClass(TesseractJob, [{
        key: 'then',
        value: function then(resolve, reject) {
            if (this._resolve.push) {
                this._resolve.push(resolve);
            } else {
                resolve(this._resolve);
            }

            if (reject) this.catch(reject);
            return this;
        }
    }, {
        key: 'catch',
        value: function _catch(reject) {
            if (this._reject.push) {
                this._reject.push(reject);
            } else {
                reject(this._reject);
            }
            return this;
        }
    }, {
        key: 'progress',
        value: function progress(fn) {
            this._progress.push(fn);
            return this;
        }
    }, {
        key: 'finally',
        value: function _finally(fn) {
            this._finally.push(fn);
            return this;
        }
    }, {
        key: '_send',
        value: function _send(action, payload) {
            adapter.sendPacket(this._instance, {
                jobId: this.id,
                action: action,
                payload: payload
            });
        }
    }, {
        key: '_handle',
        value: function _handle(packet) {
            var data = packet.data;
            var runFinallyCbs = false;

            if (packet.status === 'resolve') {
                if (this._resolve.length === 0) console.log(data);
                this._resolve.forEach(function (fn) {
                    var ret = fn(data);
                    if (ret && typeof ret.then == 'function') {
                        console.warn('TesseractJob instances do not chain like ES6 Promises. To convert it into a real promise, use Promise.resolve.');
                    }
                });
                this._resolve = data;
                this._instance._dequeue();
                runFinallyCbs = true;
            } else if (packet.status === 'reject') {
                if (this._reject.length === 0) console.error(data);
                this._reject.forEach(function (fn) {
                    return fn(data);
                });
                this._reject = data;
                this._instance._dequeue();
                runFinallyCbs = true;
            } else if (packet.status === 'progress') {
                this._progress.forEach(function (fn) {
                    return fn(data);
                });
            } else {
                console.warn('Message type unknown', packet.status);
            }

            if (runFinallyCbs) {
                this._finally.forEach(function (fn) {
                    return fn(data);
                });
            }
        }
    }]);

    return TesseractJob;
}();

},{"../node/index.js":3}],6:[function(require,module,exports){
'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var adapter = require('./node/index.js');
var circularize = require('./common/circularize.js');
var TesseractJob = require('./common/job');
var version = require('../package.json').version;

var create = function create() {
	var workerOptions = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

	var worker = new TesseractWorker(Object.assign({}, adapter.defaultOptions, workerOptions));
	worker.create = create;
	worker.version = version;
	return worker;
};

var TesseractWorker = function () {
	function TesseractWorker(workerOptions) {
		_classCallCheck(this, TesseractWorker);

		this.worker = null;
		this.workerOptions = workerOptions;
		this._currentJob = null;
		this._queue = [];
	}

	_createClass(TesseractWorker, [{
		key: 'recognize',
		value: function recognize(image) {
			var _this = this;

			var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

			return this._delay(function (job) {
				if (typeof options === 'string') options = { lang: options };
				options.lang = options.lang || 'eng';

				job._send('recognize', { image: image, options: options, workerOptions: _this.workerOptions });
			});
		}
	}, {
		key: 'detect',
		value: function detect(image) {
			var _this2 = this;

			var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

			return this._delay(function (job) {
				job._send('detect', { image: image, options: options, workerOptions: _this2.workerOptions });
			});
		}
	}, {
		key: 'terminate',
		value: function terminate() {
			if (this.worker) adapter.terminateWorker(this);
			this.worker = null;
			this._currentJob = null;
			this._queue = [];
		}
	}, {
		key: '_delay',
		value: function _delay(fn) {
			var _this3 = this;

			if (!this.worker) this.worker = adapter.spawnWorker(this, this.workerOptions);

			var job = new TesseractJob(this);
			this._queue.push(function (e) {
				_this3._queue.shift();
				_this3._currentJob = job;
				fn(job);
			});
			if (!this._currentJob) this._dequeue();
			return job;
		}
	}, {
		key: '_dequeue',
		value: function _dequeue() {
			this._currentJob = null;
			if (this._queue.length) {
				this._queue[0]();
			}
		}
	}, {
		key: '_recv',
		value: function _recv(packet) {
			if (packet.status === 'resolve' && packet.action === 'recognize') {
				packet.data = circularize(packet.data);
			}

			if (this._currentJob.id === packet.jobId) {
				this._currentJob._handle(packet);
			} else {
				console.warn('Job ID ' + packet.jobId + ' not known.');
			}
		}
	}]);

	return TesseractWorker;
}();

module.exports = create();

},{"../package.json":2,"./common/circularize.js":4,"./common/job":5,"./node/index.js":3}]},{},[6])(6)
});

/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map