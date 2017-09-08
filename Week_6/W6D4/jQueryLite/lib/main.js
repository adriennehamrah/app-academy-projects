const DOMNodeCollection = require('./dom_node_collection');

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
