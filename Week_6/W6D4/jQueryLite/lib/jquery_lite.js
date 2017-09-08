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

const DOMNodeCollection = __webpack_require__(1);

window.$l = function (arg) {
  let domNodeInstance = null;

  if (typeof arg === 'string'){
    const nodeList = document.querySelectorAll(arg);
    const arrayList = Array.from(nodeList);
    domNodeInstance = new DOMNodeCollection(arrayList);
    return domNodeInstance;
  } else if (arg instanceof HTMLElement) {
    domNodeInstance = new DOMNodeCollection([arg]);
  }
  return domNodeInstance;
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(HTMLElements) {
    this.nodes = HTMLElements;
  }
  html (string = null) {
    if (!string) {
      return this.nodes[0].innerHTML;
    }
    else {
      this.nodes.forEach((node) => {
        node.innerHTML = string;
      });
    }
  }

  empty() {
    this.nodes.forEach((node) => {
      node.innerHTML = "";
    });
  }

  append(input) {
    this.nodes.forEach( el => {
      if (typeof input === 'string') {
        el.innerHTML += input;
      } else if (input instanceof HTMLElement) {
        el.innerHTML += input.outerHTML;
      } else if (input instanceof DOMNodeCollection){
        el.innerHTML += input.nodes[0].outerHTML;
      }
    });
  }

  attr(attrName, ...args) {
    if (args.length === 0) {
      return this.nodes[0].getAttribute(attrName);
    } else if(args[0] === null){
      this.nodes[0].removeAttribute(attrName);
    } else {
      this.nodes[0].setAttribute(attrName, args[0]);
    }
  }

  addClass(classnames) {
    this.nodes.forEach(node => {
      classnames.forEach (classname => {
        node.classList.add(classname);
      });
    });
  }

  removeClass(classnames) {
    this.nodes.forEach(node => {
      classnames.forEach (classname => {
        node.classList.remove(classname);
      });
    });
  }

  children() {
    let children = [];
    this.nodes.forEach(node => {
      let curChildren = node.children;
      children = children.concat(node.children);
    });
    return new DOMNodeCollection(children);
  }

  parent() {
    let parent =  this.nodes[0].parentNode;
    return new DOMNodeCollection(parent);
  }

}


module.exports = DOMNodeCollection;

window.DOMNodeCollection = DOMNodeCollection;


/***/ })
/******/ ]);