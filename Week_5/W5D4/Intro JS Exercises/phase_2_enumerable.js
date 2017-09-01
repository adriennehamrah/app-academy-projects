Array.prototype.myEach = function myEach(callback){
  for (let i = 0; i < this.length; i++){
    callback(this[i]);
  }
};

const cb = (el) => {
  return el;
};

Array.prototype.myMap = function myMap(callback){
  const resArray = [];
  for (let i = 0; i < this.length; i++){
    resArray.push(callback(this[i]));
  }
  return resArray;
};

const cb1 = (el) => {
  return el * 2;
};

Array.prototype.myReduce = function myReduce(callback, initialValue) {
  if (initialValue) {
    let acc = initialValue;
    this.myEach(el => {
      acc = acc + callback(el);
    });
    return acc;
  }
  else {
    let acc = this[0];
    this.slice(1).myEach((el) => {
      acc = acc + callback(el);
    });
    return acc;
  }
};
