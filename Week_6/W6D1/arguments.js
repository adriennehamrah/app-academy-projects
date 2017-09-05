// function  sum(arg) {
//   let args  = Array.prototype.slice.call(arguments);
//   let total = 0;
//   args.forEach( (el) => {
//   total += el;
//   });
//   return total;
// }
//
// // console.log(sum(1, 2, 3, 4));
//
// function sum(...args) {
//   let total = 0;
//   args.forEach( (el) => {
//     total += el;
//   });
//   return total;
// }
//
// console.log(sum(1, 2, 3, 4, 5));

Function.prototype.myBind = function (target, ...bindArgs) {
  return (...callArgs) => {
    let args = bindArgs.concat(callArgs);
    this.apply(target, args);
  };
};


class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

// markov.says.myBind(breakfast, "meow", "Kush")();
// markov.says.myBind(breakfast)("meow", "a tree");
// markov.says.myBind(breakfast, "meow")("Markov");
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");

function curriedSum(numArgs) {
  let numbers = [];
  return function _curriedSum (num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      let total = 0;
      numbers.forEach( (el) => {
        total += el;
      });
      return total;
    } else {

        return _curriedSum;
    }
  };
}


let sum = curriedSum(4);
sum(5);
sum(30);
sum(20);
// console.log(sum(1));

Function.prototype.curry = function(numArgs) {
  let self = this;
  const args = [];
  return function _curry(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return self(...args);
    } else {
      return _curry;
    }
  };
};

function subtract(...args) {
  let total = args[0];
  args.slice(1).forEach( (el) => {
    total = total - el;
  });
  return total;
}

let res = subtract.curry(3);
// console.log(res(10)(3)(1));
