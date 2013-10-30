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
  float bearingStep = 10; // number of iterations till same bearing

  Snuggler(float x, float y, float b, float speed) {
    super(x, y, b, speed);
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
  }

  void notice(Snuggler other) {
    float dist = distance(other);
    if (dist <  seeingness) {
      println("change bearing");
    }
  }

  float distance(Inchworm other) {
    float dist = sqrt(sq(this.xhead - other.xhead) + sq(this.yhead - other.yhead));
    // println("dist: " + dist);
    return dist;
  }
};

void setup () {
  size(MAX_W, MAX_H);
  worms.add(new Snuggler(100, 400, 0.0, 0.1));
  worms.add(new Snuggler(400, 100, PI/2.0, 0.1));

  // int wormCount = 2; //(int)random(5, 100);
  // println("wormCount: " + wormCount);
  // for (int i = 0; i < wormCount; i++) {
  //   worms.add(new Snuggler());
  // }
}

void draw() {
  background(255);
  for (int i=0; i<worms.size(); i++) {
    Snuggler current = worms.get(i);

    for (int j = i+1; j < worms.size(); j++) {
      Snuggler other = worms.get(j);
      current.notice(other);
    }

    worms.get(i).step();
  }
}