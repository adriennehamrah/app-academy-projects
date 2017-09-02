class MyDate {
  constructor(hr, min, sec) {
    // 1. Create a Date object.
    this.hour = hr;
    this.minutes = min;
    this.seconds = sec;
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.  
   }

      
}

class Clock {
    constructor(hr, min, sec) {
        // 1. Create a Date object.
        // 2. Store the hours, minutes, and seconds.
        this.hours = hr;
        this.minutes = min;
        this.seconds = sec;
        // 3. Call printTime.
        this.printTime();
        // 4. Schedule the tick at 1 second intervals. 
        this.tickInterval = setInterval(this._tick.bind(this), 1000);
        setTimeout(this.stop.bind(this), 5000)
    }

    stop(){
        clearInterval(this.tickInterval)
    }

    pad0(t){
        return t >= 10 ? t : '0' + t;
    }

    printTime() {// Format the time in HH:MM:SS
    // Use console.log to print it.
        print = [this.hours, this.minutes, this.seconds].map(this.pad0).join(":");
        console.log(
            print
        );

        //Document.body.innerHTML = print;
    }

    minutesRollOver(){
        this.hours++;
        this.hours > 12 && (this.hours = 0)
        this.minutes = 0;
    }

    secondsRollOver(){
        this.minutes++;
        this.minutes > 59 && this.minutesRollOver()
        this.seconds = 0;
    }

    _tick() {// 1. Increment the time by one second.
    // 2. Call printTime.
        this.seconds++
        this.seconds > 59 && this.secondsRollOver()
        this.printTime()
    }
}

const clock = new Clock(5, 20, 45);