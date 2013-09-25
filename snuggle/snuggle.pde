// litle inchworm snugglers (various colors. skintones?)
// move (inch?) around, and then cuddle/snuggle for a while
// some small number for max in a snuggle group 

ArrayList<Snuggler> snugglers;

class Position {
  float x;
  float y;

  Position () {
  	// x = 0;
  	// y = 0;
  }

  Position (float xPos, float yPos) {
  	x = xPos;
  	y = yPos;
  }
  
};

class Snuggler {

	Position pos;
	float w; 
	float l;
	color col;
	float bearing;
	//distance in time step, speed.
	float dit;

	Snuggler () {
		pos = new Position();
		w = 30.0;
		l = 60.0;
		col = color(255,255,255,255);
		bearing = 0.0;
		dit = 5.0;
	}

	Snuggler(float startX, float startY) {
		pos = new Position(startX, startY);
		w = 30.0;
		l = 60.0;
		col = color(255,255,255,255);
		bearing = 0.0;
		dit = 5.0;
	}

	Snuggler(float startX, float startY, color c) {
		pos = new Position(startX, startY);
		w = 30.0;
		l = 60.0;
		col = c;
		bearing = 0.0;
		dit = 5.0;
	}

	Snuggler(float startX, float startY, color c, float b) {
		pos = new Position(startX, startY);
		w = 30.0;
		l = 60.0;
		col = c;
		bearing = 360-b;
		dit = 5.0;
	}

	Snuggler(Position startPos, float wid, float len) {
		pos = startPos;
		w = wid;
		l = len;
		col = color(255,255,255,255);
		bearing = 0.0;
		dit = 5.0;
	}

	Snuggler(float startX, float startY, float wid, float len) {
		pos = new Position(startX, startY);
		w = wid;
		l = len;
		col = color(255,255,255,255);
		bearing = 0.0;
		dit = 5.0;
	}

	Snuggler(Position startPos, float wid, float len, color c) {
		pos = startPos;
		w = wid;
		l = len;
		col = c;
		bearing = 0.0;
		dit = 5.0;
	}

  Snuggler(Position startPos, float wid, float len, color c, float b) {
		pos = startPos;
		w = wid;
		l = len;
		col = c;
		bearing = 360-b;
		dit = 5.0;
	}

	void step() {
		pos.x += dit * cos(radians(bearing));
		pos.y += dit * sin(radians(bearing));
	}

  void draw() {
  	step();
		fill(col);
		// draw tail
		ellipse(pos.x,pos.y, w, w);

		// draw body
		// because rotate is weird like a graphics stack,
		// use quad. need to then calculate the position of each corner.
		// tl is the center of the circle (pos.x, pos.y), 
		// but moved by radius (w/2) perpendicular to bearing
		float tlX = pos.x - (w/2.0 * cos(radians(bearing+90)));
		float tlY = pos.y - (w/2.0 * sin(radians(bearing+90)));		

		// the rest are more straight forward trig
		float trX = tlX + (l * cos(radians(bearing)));
		float trY = tlY + (l * sin(radians(bearing)));

		float brX = trX - (w * cos(radians(bearing-90)));
		float brY = trY - (w * sin(radians(bearing-90)));
		
		float blX = tlX - (w * cos(radians(bearing-90)));
		float blY = tlY - (w * sin(radians(bearing-90)));
		quad(tlX, tlY, trX, trY, brX, brY, blX, blY);

		// draw head
		float headX = pos.x + (l * cos(radians(bearing)));
		float headY = pos.y + (l * sin(radians(bearing)));	
		ellipse(headX, headY, w, w);
	}
};

void setup() {
	size(640, 360);
	noStroke();

	snugglers = new ArrayList<Snuggler>();
	snugglers.add(new Snuggler(100,100));
	snugglers.add(new Snuggler(320,180, color(0,128,200,255), 45.0));
}

void draw() {
	background(0);
	for (int i=0; i<snugglers.size(); i++) {
		snugglers.get(i).draw();
	}
}