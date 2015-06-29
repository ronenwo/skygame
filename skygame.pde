

ArrayList<Balloon> helloBalloons = new ArrayList<Balloon>();


Balloon hell;
PVector wind, gravity;
PVector leftWind, rightWind;
float xoff = 0.0f;

float vx = 0.0f;
float vy = 0.05f;

float windLeft = 0.0f;
float windRight = 0.0f;


int frameCountLeft = 0;
int frameCountRight = 0;

boolean syncOn = false;
PGraphics birdsLayer;
PGraphics pumpLayer;


Animation birdAnim;
Animation pumpLeftAnim;
Animation birdInBalloonAnim;

boolean pumpLeftOn = false;

PImage vente;

PImage birdInBalloon;

void setup(){  
  background(255);  
  size(500,500);
  vente = loadImage("venta000001.png");
  birdInBalloon = loadImage("balloon1.png");
  
  birdsLayer = createGraphics(width,height);
  pumpLayer = createGraphics(width,height);
  
  birdAnim = new Animation(birdsLayer,"bird_color_green",2,
    width/2,0, 
    0.0, 1.0f, 
    50, 50);

  birdInBalloonAnim = new Animation(birdsLayer,"balloon",1,
    0,0, 
    0.0, -1.0f, 
    50, 74);


  birdInBalloonAnim.enable = false;

  pumpLeftAnim = new Animation(pumpLayer,"venta00000",4,
    10,10, 
    0.0, 0.0f, 
    0, 0);
    
  


  gravity = new PVector(0, 0.007f);
  wind = new PVector(0.0, 0);
  leftWind = new PVector(0.0, 0);
  rightWind = new PVector(0.0, 0);
}


void draw(){
  background(255);
    
    for (Balloon balloon: helloBalloons) {
      balloon.update();
      if (balloon.checkEdges()) {
        helloBalloons.remove(balloon);
        Balloon b = new Balloon(70.0, 0.02f, 0.0005f);
        helloBalloons.add(b);
        wind.set(0.0,0.0);
        break;
      }
      if (rectRect(balloon.location.x,balloon.location.y,balloon.mwidth,balloon.mheight,
                    birdAnim.getX(), birdAnim.getY(),birdAnim.dim.x,birdAnim.dim.y)){
         birdInBalloonAnim.updateLocation(birdAnim.getX(), birdAnim.getY()); 
         birdInBalloonAnim.enable = true;
         birdAnim.updateReset();
         balloon.enable = false;
      }
      balloon.display();
      if (!syncOn){
        balloon.applyForce(gravity);
      }
      balloon.applyForce(wind);
//      balloon.applyLeftForce(leftWind);
//      balloon.applyRightForce(rightWind);
  }

      birdsLayer.beginDraw();
      birdsLayer.background(255,0);
      birdAnim.update();
      birdAnim.display();
      birdInBalloonAnim.update();
      birdInBalloonAnim.display();
      birdsLayer.endDraw();

  
    if (syncOn){
      wind.set(0.0f,0.0f);
      syncOn = false;
    }
    image(birdsLayer,0,0);
    if (pumpLeftOn){
      pumpLayer.beginDraw();
      pumpLayer.background(255,0);
      boolean lastFrame = pumpLeftAnim.display();
      pumpLayer.endDraw();
      image(pumpLayer,0,0);
      if (lastFrame){
         pumpLeftOn = false; 
      }
    }else{
      image(vente,10,10);
    }
}
 

// RECTANGLE/RECTANGLE
boolean rectRect(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {
  
  // are the sides of one rectangle touching the other?
  
  if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}


public void mouseClicked() {
  Balloon b = new Balloon(70, 0.0f, 0.0005f);
  helloBalloons.add(b);
  
}


void keyPressed() {
  println("keyPressed="+key);

    float add1 = 0.005f;
    float add2 = 0.01f;
    
    if (key == 'z') {
      if (wind.x>=0){
        wind.add(add1,0,0);
      }
      else{
        wind.add(add2,0,0);
      }
      frameCountLeft = frameCount;
      pumpLeftOn = true;
    } else if (key == 'x') {
      if (wind.x<=0){
        wind.sub(add1,0,0);
      }
      else{
        wind.sub(add2,0,0);
      }
      frameCountRight = frameCount;
    } else if (key == 'b') {
//      wind.set(0.0f,-1.5f);
      frameCountRight = frameCount;
      frameCountLeft = frameCount;
      pumpLeftOn = true;
    } else if (key == 'B') {
      
    } 
    
    if ( (Math.abs(frameCountLeft - frameCountRight)<2)){
      wind.set(0.0f,-0.05f);
      syncOn = true;
    }
}


public void windChanges() {
  float windChange = noise(xoff);
  xoff = xoff + 0.01f;
  wind.set(windChange*0.09f, 0.0f, 0.0f);
}



