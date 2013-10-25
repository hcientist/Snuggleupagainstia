// litle inchworm snugglers (various colors. skintones?)
// move (inch?) around, and then cuddle/snuggle for a while
// some small number for max in a snuggle group 

// Inchworm i = new Inchworm();
// ArrayList<Inchworm> worms = new ArrayList<Inchworm>();

class Snuggler extends Inchworm {

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

};

void setup () {
	size(MAX_W, MAX_H);

  int wormCount = (int)random(5, 100);
  println("wormCount: " + wormCount);
  for (int i = 0; i < wormCount; i++) {
    worms.add(new Snuggler());
  }
}

void draw() {
  background(255);
  for (int i=0; i<worms.size(); i++) {
    worms.get(i).step();
  }
}