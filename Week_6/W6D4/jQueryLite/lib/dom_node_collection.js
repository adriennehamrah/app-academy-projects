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
