function range(start, end) {
  if (start === end) return start;
  const resArray = [start];
  return resArray.concat(range(start + 1, end));
}

function sumRec(arr) {
  if (arr.length === 1) return arr[0];
  return arr[0] + sumRec(arr.slice(1));
}

function exponent1(base, exp) {
  if (exp === 0) return 1;
  return base * exponent1(base, exp - 1);
}

function exponent2(base, exp) {
  if (exp === 0) return 1;
  if (exp === 1) return base;
  if (exp % 2 === 0) {
    return Math.pow(exponent2(base, exp / 2), 2);
  }
  else {
    return base * Math.pow(exponent2(base, (exp - 1)/2), 2);
  }
}

function fibbonacci(n){
  if (n <= 2) return [0,1].slice(0, n+1);
  let fib = fibbonacci(n-1);
  return fib.concat(fib[fib.length-1] + fib[fib.length-2]);
}

function bsearch(arr, target){
  console.log(arr);
  const midpoint = Math.floor(arr.length/2);

  if (arr[midpoint] === target) return midpoint;
  else if (arr[midpoint] > target) {
    return bsearch(arr.slice(0, midpoint), target);
  }
  else if (arr[midpoint] < target) {
    const subres = bsearch(arr.slice(midpoint), target);
    return subres === -1 ? -1 : midpoint + subres;
  }
  else if (arr.length <= 1) return -1;
}

function mergeSort(arr){
  if (arr.length <= 1) return arr;
  const mid = Math.floor(arr.length / 2);
  const left = arr.slice(0,mid);
  const right = arr.slice(mid);
  return merge(mergeSort(left), mergeSort(right));
}

function merge(left, right){
  const sorted = [];
  while (left.length > 0 && right.length > 0){
    if (left[0] < right[0]) {
      sorted.push(left.shift());
    }
    else if (right[0] < left[0]){
      sorted.push(right.shift());
    }
    else {
      sorted.push(left.shift());
    }
  }
  return sorted.concat(left).concat(right);
}

function subsets(arr){
  if (arr.length === 0) return [[]];
  else {
    const temp = subsets(arr.slice(0,-1));
    console.log(temp);
    const mapped = temp.map(el => el.concat([arr[arr.length - 1]]));
    console.log(mapped);
    return temp.concat(mapped);
  }
}
