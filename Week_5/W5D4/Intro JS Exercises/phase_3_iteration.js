Array.prototype.bubbleSort = function bubbleSort() {
  let sorted = false;
  while (sorted === false){
    sorted = true;
    let i = 0;
    while (i < this.length - 1) {
      let j = i + 1;
      if (j === this.length){ break; }
      if (this[i] > this[j]) {
        let jTemp = this[j];
        this[j] = this[i];
        this[i] = jTemp;
        sorted = false;
      }
      i++;
    }
  }
  return this;
};

String.prototype.substrings = function substrings () {
  const resArray = [];
  let i = 0;
  while (i < this.length) {
    resArray.push(this[i]);
    let j = i + 1;
    if (j === this.length) break;
    while (j < this.length) {
      resArray.push(this.slice(i, j + 1));
      j++;
    }
    i++;
  }
  return resArray.uniq();
};
