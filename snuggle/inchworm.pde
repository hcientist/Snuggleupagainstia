// float di = 0.01;
int MIN_W = 0;
int MIN_H = 0;
int MAX_W = 1440;
int MAX_H = 900;

ArrayList<Inchworm> worms = new ArrayList<Inchworm>();

class Position {
  float x;
  float y;

  Position () {}

  Position (float xPos, float yPos) {
    x = xPos;
    y = yPos;
  }
  
};

// float randomRange(min, max) {
//   return Math.random() * (MAX_INCHY_RATIO - MIN_INCHY_RATIO) + MIN_INCHY_RATIO
// }

class Inchworm {
  float w;          // width of worm
  float l;          // length of worm
  float inchHeight; // max diff in "height" of flat and "inched" worm
  float inched;     // 0.0 - 1.0: how "inched" is the worm (0=not inched, 1=fully inched)
  float bearing;    // current bearing
  float x;          // current x position of worm tail
  float y;          // current y position of worm tail
  color c;          // color of this worm
  float speed;
  float di;

  float theta;
  float hypot;
  float xh;
  float yh;
  float xhtc;
  float yhtc;
  float xhhc;
  float yhhc;
  float xtc;
  float ytc;
  float xhc;
  float yhc;
  float xhead;
  float yhead;

  float MAX_WORM_WIDTH = 100;
  float MIN_WORM_WIDTH = 10;
  float MAX_L_RATIO = 3.0;
  float MIN_L_RATIO = 1.0;
  float MAX_INCHY_RATIO = 3.0/4.0;
  float MIN_INCHY_RATIO = 1.0/4.0;

  void setup() {
    x = random(MAX_W);
    y = random(MAX_H);

    bearing = random(TAU);
    c = color(random(255), random(255), random(255));

    w = random(MIN_WORM_WIDTH, MAX_WORM_WIDTH);
    l = w * random(MIN_L_RATIO, MAX_L_RATIO);

    inched = random(1.0);
    inchHeight = l * random(MIN_INCHY_RATIO, MAX_INCHY_RATIO);

    speed = random(0.005, 0.2);
    di = speed;
  }

  Inchworm(float x, float y, color c, float b) {
    setup();

    this.x = x;
    this.y = y;
    this.bearing = b;
    this.c = c;
  }

  Inchworm() {
    setup();
  }

  float inchiness() {
    return inched*inchHeight;
  }

  void update() {
    theta = atan(inchiness()/(l/2.0));
    hypot = sqrt(sq(inchiness())+sq(l/2.0));
    xh = hypot * cos(bearing-theta) + x; // note to self, think about degrees/radians and processing's origin
    yh = hypot * sin(bearing-theta) + y; // note to self, think about degrees/radians and processing's origin
    xhtc = xh - l/4.0 * cos(bearing);
    yhtc = yh - l/4.0 * sin(bearing);
    xhhc = xh + l/4.0 * cos(bearing);
    yhhc = yh + l/4.0 * sin(bearing);
    xtc = x + l/4.0 * cos(bearing);
    ytc = y + l/4.0 * sin(bearing);
    xhc = x + 3.0*l/4.0 * cos(bearing);
    yhc = y + 3.0*l/4.0 * sin(bearing);
    xhead = x + l * cos(bearing);
    yhead = y + l * sin(bearing);
  }

  void draw() {
    strokeWeight(w);
    // fill(255);
    stroke(c);
    beginShape();
    vertex(x, y);
    bezierVertex(xtc, ytc, xhtc, yhtc, xh, yh);
    bezierVertex(xhhc, yhhc, xhc, yhc, xhead, yhead);
    endShape();
  }

  void wrap() {
    if (di >=0 ) {
      float modBearing = (bearing % TAU);

      if (x + w < MIN_W && !(modBearing > -HALF_PI && modBearing < HALF_PI)) { // off screen to left
        x = MAX_W + (l + w);
      } else if (x - w > MAX_W && modBearing > -HALF_PI && modBearing < HALF_PI) { // off screen to right
        x = 0 - (l + w);
      }

      if (y + w < MIN_H && !(modBearing > 0 && modBearing < PI)) { // off screen to top
        y = MAX_H + (l + w);
      } else if (y - w > MAX_H && modBearing > 0 && modBearing < PI) { // off screen to bottom
        y = 0 - (l + w);
      }
    }
  }

  void animate() {
    // make the worm hump oscillate
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

  void step() {
    update();
    draw();
    animate();    
    wrap();
  }
};

// void setup () {
// 	size(MAX_W, MAX_H);

//   int wormCount = (int)random(5, 100);
//   println("wormCount: " + wormCount);
//   for (int i = 0; i < wormCount; i++) {
//     worms.add(new Inchworm());
//   }
// }

// void draw() {
//   background(255);
//   for (int i=0; i<worms.size(); i++) {
//     worms.get(i).step();
//   }
// }