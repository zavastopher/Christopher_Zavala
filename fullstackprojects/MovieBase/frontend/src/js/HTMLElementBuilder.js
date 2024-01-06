export default class HTMLElementBuilder {
  constructor(tag) {
    this.element = document.createElement(tag);
  }

  setAttribute(attribute, value) {
    this.element.setAttribute(attribute, value);
    return this; 
  }

  setText(text) {
    this.element.textContent = text;
    return this; 
  }

  addChild(childElement) {
    this.element.appendChild(childElement);
    return this; 
  }

  build() {
    return this.element;
  }
}