// litle inchworm snugglers (various colors. skintones?)
// move (inch?) around, and then cuddle/snuggle for a while
// some small number for max in a snuggle group 

// Inchworm i = new Inchworm();
ArrayList<Snuggler> worms = new ArrayList<Snuggler>();

int MIN_W = 0;
int MIN_H = 0;
int MAX_W = 1440;
int MAX_H = 800;


class Snuggler extends Inchworm {

  ArrayList<Snuggler> noticedWorms = new ArrayList<Snuggler>();

  float seeingness = 300.0; // dependent on number of worms and/or length?
  float bearingStep = radians(5); // amount to turn when noticing other worm

  float previousBearing;
  boolean dirty;

  Snuggler(float x, float y, float b, float speed) {
    super(x, y, b, speed);
    previousBearing = this.bearing;
    this.dirty = true;
  }

  void update() {
    super.update();
    dirty = true;
  }

  void animate() {
    if (inched >= 1.0) {
      di = -speed;
    }
    else if (inched <= 0.0) {
      di = speed;
    }

    l = l - di*inchHeight;

    inched += di;
    
    if (di >=0 ){ // when di > 0, we're moving the tail.
      x += di*inchHeight*cos(bearing);
      y += di*inchHeight*sin(bearing);
    }

    react();
  }

  void react() {
    previousBearing = bearing;
    for (int i=0; i < worms.size(); i++) {
      if (this != worms.get(i)) {
        this.notice(worms.get(i));

        if (this.snuggling(worms.get(i))) {
          println("I am snuggling with worm " + i);
          // Worms should average towards each other
          //   color, size, etc should change towards the average of the two worms values
        }
      }
    }
    dirty = false;
  }

  boolean snuggling(Snuggler other) {
    //if our head or tail is within a threshold of other's head or tail
    // println("this.headDistance(other): "+this.headDistance(other));
    float threshold = 50;
    if ((this.headDistance(other) < threshold || this.distance(this.xhead, other.x, this.yhead, other.y) < threshold) &&
        (this.tailDistance(other) < threshold || this.distance(this.x, other.xhead, this.y, other.yhead) < threshold)) {
      return true;
    }
    return false;
  }

  float getBearing() {
    if (dirty) {
      return bearing;
    }
    return previousBearing;
  }

  void notice(Snuggler other) {

    // println(this+" notice "+other);
    float dist = headDistance(other);
    if (dist <  seeingness) {
      float newBearing = this.bearingTo(other);
      // println("change bearing "+ this.bearing + ": by: "+ newBearing);
      this.bearing = newBearing;//this.bearing+newBearing; //something's not right here
    }
  }

  float headDistance(Snuggler other) {
    float dist = sqrt(sq(this.xhead - other.xhead) + sq(this.yhead - other.yhead));
    // println("dist: " + dist);
    return dist;
  }

  float tailDistance(Snuggler other) {
    float dist = sqrt(sq(this.x - other.x) + sq(this.y - other.y));
    // println("dist: " + dist);
    return dist;
  }

  float distance(float ax,float ay,float bx,float by) {
    return sqrt(sq(ay-by) + sq(ax-bx));
  }

  float bearingTo(Snuggler other) {
    // float theta = atan((this.yhead - other.yhead)/(this.xhead - other.xhead));
    float theta = (this.getBearing() + other.getBearing()) / 2.0;
    float bearingDelta = (theta - this.getBearing()) * .03; // don't turn too much

    // println("theta "+theta);
    // println("this.bearing: "+this.bearing);
    // println("other.bearing: "+other.bearing);

    // if (abs(theta) < radians(10)) {
    //   println("don't change course!");
    //   bearingDelta = 0;
    // }
    return this.bearing + bearingDelta;
  }
};

// void setup () {
//   size(MAX_W, MAX_H);
//   worms.add(new Snuggler(100, 400, 0.0, 0.1));
//   worms.add(new Snuggler(400, 400, -PI/2.0, 0.1));

//   // int wormCount = 2; //(int)random(5, 100);
//   // println("wormCount: " + wormCount);
//   // for (int i = 0; i < wormCount; i++) {
//   //   worms.add(new Snuggler());
//   // }
// }

// void draw() {
//   background(255);
//   for (int i=0; i<worms.size(); i++) {
//     // Snuggler current = worms.get(i);

//     // for (int j = i+1; j < worms.size(); j++) {
//     //   Snuggler other = worms.get(j);
//     //   current.notice(other);
//     // }

//     worms.get(i).step();
//   }
// }