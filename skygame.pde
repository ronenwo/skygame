

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

boolean pumpLeftOn = false;

PImage vente;

void setup(){  
  background(255);  
  size(500,500);
  vente = loadImage("venta000001.png");
  birdsLayer = createGraphics(width,height);
  pumpLayer = createGraphics(width,height);
  
  birdAnim = new Animation(birdsLayer,"bird_color_green",2,
    width/2,0, 
    0.0, 1.0f, 
    50, 50);

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
      birdsLayer.endDraw();


      birdsLayer.beginDraw();
      birdsLayer.background(255,0);
      birdAnim.update();
      birdAnim.display();
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



