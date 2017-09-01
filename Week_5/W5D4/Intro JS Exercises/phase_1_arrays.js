Array.prototype.uniq = function uniq(){
  const uniqueArray = [];
  this.forEach((el) => {
    if (!uniqueArray.includes(el)) {
      uniqueArray.push(el);
    }
  });
  return uniqueArray;
};

Array.prototype.twoSum = function twoSum(){
  const resArray = [];
  let i = 0;
  while (i < this.length) {
    let j = i + 1;
    while (j < this.length) {
      if (this[i] + this[j] === 0) {
        resArray.push([i,j]);
      }
      j++;
    }
    i++;
  }
  return resArray;
};

Array.prototype.transpose = function transpose(){
  const resArray = [];
  let col = 0;
  while (col < this[0].length) {
    let row = 0;
    const rowArr = [];
    while (row < this.length) {
      rowArr.push(this[row][col]);
      row++;
    }
    resArray.push(rowArr);
    col++;
  }
  return resArray;
};
