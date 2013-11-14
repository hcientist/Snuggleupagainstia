Snuggler s0 = new Snuggler(150, 400, 0.0, 0.1);
Snuggler s1 = new Snuggler(400, 400, -PI/2.0, 0.1);

void setup() {
  size(MAX_W, MAX_H);
  worms.add(s0);
  worms.add(s1);
}

void draw() {
  background(255);
  s0.step();
  s1.step();
}