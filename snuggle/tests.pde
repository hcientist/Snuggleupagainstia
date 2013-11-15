Snuggler s0 = new Snuggler(150, 400, 0.0, 0.1);
Snuggler s1 = new Snuggler(400, 400, -PI/2.0, 0.1);

void setup() {
  size(MAX_W, MAX_H);
  worms.add(s0);
  worms.add(s1);

  int wormCount = 15; //(int)random(5, 100);
  println("wormCount: " + wormCount);
  for (int i = 0; i < wormCount; i++) {
    worms.add(new Snuggler(random(MAX_W), random(MAX_H), random(TWO_PI), 0.1));
  }
  println("worms.size(): "+worms.size());
}

void draw() {
  background(255);
  // s0.step();
  // s1.step();
  for (int i=0; i<worms.size(); i++) {
    worms.get(i).step();
  }

}