class Ball {
  // class data
  PVector origPosition, position, velocity, gravity, force;
  int scale = int(videoScale*0.667);
  int i;
  float brightness;
  color c;
  AudioSample snare;
  
  // class constructor
  Ball(int x, int y, int i) {
    this.origPosition = new PVector(x+(scale/2),y+videoScale);
    this.position = new PVector(x+(scale/2),y);
    this.velocity = new PVector(0,0);
    this.gravity = new PVector(0,0.35);
    this.force = new PVector();
    this.i = i;
    this.brightness = 0;
    this.snare = minim.loadSample(bells[soundCount]);
    soundCount++;
    if (soundCount == bellNum) {
      soundCount = 0;
    }
//    if (this.i % 2 == 0) {this.snare = minim.loadSample( "bell_1.mp3",512);} else {
//      this.snare = minim.loadSample( "bell_1.mp3",512);}
  }
  // class methods
  
  void bop(float dif) {
    float d = map(dif, 0, 75, 0, 4);
    this.velocity.add(float(0), -d, float(0));
  }
  
  void update() {
    //dif = map(dif, 0,3000, 0, 10);
    this.force.set(gravity);
    this.velocity.add(force);
    this.velocity.mult(0.988);
    brightness=brightness*0.998;
    this.position.add(velocity);
  }
  
  void bounce() {
    if (position.y > height-(scale/2)) {
      position.y = height-(scale/2);
      if (velocity.y > 2){
        snare.setGain(map(velocity.y,0,15,-50,20));
        snare.trigger();
        brightness=brightness+(velocity.y*4);
        //println(brightness);
        //println(velocity.y);
      }
      velocity.y = -velocity.y;
    } else if (position.y < (scale/2)) {
        position.y = (scale/2);
        if (velocity.y > 0.5){
          snare.trigger();
          println(velocity.y);
        }
      velocity.y = -velocity.y;
    }
}
  
  void display() {
    c = color(arrayX[i]);
    noStroke();
    bounce();
    
    fill(c, brightness);
    triangle((origPosition.x-(scale/2)),position.y,(origPosition.x+(scale/2)),position.y,map(position.x,0,width,width*0.33,width*0.66),height*0.66);
    
    fill(c, brightness*2);
    ellipse(position.x,position.y, scale, scale);
    // add triangles which go from bottom to center, light up upon bounce
    //println(position.y);
  }
  
  
}
