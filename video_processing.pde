import processing.video.*;
import ddf.minim.*;

Minim minim;
AudioPlayer audio;
Capture video;
color[] arrayX = new color[0];
color[] arrayPX = new color[0];
float[] difference = new float[0];
ArrayList<Ball> bList = new ArrayList<Ball>();
int videoScale = 30;
String[] bells = {"bell_1.mp3","bell_2.mp3","bell_3.mp3","bell_4.mp3","bell_5.mp3","bell_6.mp3","bell_7.mp3","bell_8.mp3","bell_9.mp3"};
int bellNum = bells.length;
int soundCount = 0;

int cols, rows;
int draws = 0;

void setup() {
  //set size of window
  //size(800, 600);
  size(displayWidth, displayHeight);
  
  //set initial number for cols and rows
  cols = width/videoScale;
  rows = height/videoScale;
  
  // setup minim
  minim = new Minim(this);
//  snare = minim.loadSample( "SD.wav", // filename
//                            512      // buffer size
//                         );
  // setup video capture
  video = new Capture(this,width,height,30);
  video.start();
  video.loadPixels();
  getCentreRow();
  for (int i=0;i<arrayX.length;i++){
    bList.add(new Ball(i*videoScale, height-videoScale, i));
  }
  
  //ourAgent = new Agent(100,100, color(random(255), 155, 155));
}

void draw() {
  fill(#333333);
  rect(0,0,width,height);
  // Read image from the camera
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  getCentreRow();
  for (int i = 0; i < arrayX.length; i++) {
    fill(arrayX[i]);
    //println(arrayX[i]);
    if (draws > 0) {
      getDifference(arrayX[i], arrayPX[i]);
      //rect(i*videoScale, (2*difference[i]), videoScale, videoScale);
      Ball temp = (Ball)bList.get(i);
      //println(difference[i]);
      if (difference[i]>1) {
        temp.bop(difference[i]);
      }
      temp.update();
      temp.display();
    }
    noStroke();
    //rect(i*videoScale, height-videoScale, videoScale, videoScale);
  }
  arrayPX = arrayX;
  arrayX = new color[0];
  difference = new float[0];
  if (draws%200 == 0) {
    println("draws = 30");
    PImage pg = video.get();
    pg.save("images/image_"+draws+".png");
  }
  draws++;
}
  
  
void getCentreRow() {
  
  for (int ix = 0; ix<cols; ix++) {
      int loc=(ix*videoScale)+((height/2)*video.width);
      arrayX = append(arrayX, color(video.pixels[loc]));
      //println(color(video.pixels[loc]));
  }
  arrayX = reverse(arrayX);
}

void getDifference(color c, color pc) {
  float diff = brightness(c) - brightness(pc);
  difference = append(difference, diff);
}
