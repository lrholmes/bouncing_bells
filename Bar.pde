class Bar {
  // class data
  PVector position, velocity, gravity, force;
  int scale = int(videoScale*0.667);
  int i;
  color c;
  int posY = height-videoScale;
  
  // class constructor
  Bar(int x, int y, int i) {
    this.position = new PVector(x+(scale/2),y);
    this.velocity = new PVector(0,0);
    this.gravity = new PVector(0,0.35);
    this.force = new PVector();
    this.i = i;
  }
  // class methods
  
  void bop(float dif) {
    float d = map(dif, 0, 100, 0, 5);
    this.velocity.add(float(0), -d, float(0));
  }
  
  void update() {
    //dif = map(dif, 0,3000, 0, 10);
    this.force.set(gravity);
    this.velocity.add(force);
    this.velocity.mult(0.99);
    this.position.add(velocity);
  }
  
  void bounce() {
    if (position.y > height-2) {
      position.y = height-2;
      velocity.y = -velocity.y;
    } else if (position.y < 0) {
      position.y = 0;
      velocity.y = -velocity.y;
    }
}
  
  void display() {
    c = color(arrayX[i]);
    fill(c);
    noStroke();
    bounce();
    rect(position.x,position.y, scale, height);
    println(position.y);
  }
  
  
}
