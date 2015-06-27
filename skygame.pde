import gifAnimation.*;






ArrayList<Balloon> helloBalloons = new ArrayList<Balloon>();

ArrayList<Birdy> birds = new ArrayList<Birdy>();


Balloon hell;
PVector wind, gravity;
float xoff = 0.0f;

float vx = 0.0f;
float vy = 0.05f;

float windLeft = 0.0f;
float windRight = 0.0f;

int leftClicksInDelta = 0;
int rightClicksInDelta = 0; 

boolean leftClicked = false;
boolean rightClicked = false;

int frameCountLeft = 0;
int frameCountRight = 0;

boolean syncOn = false;

GifAnimation birdy;

PGraphics birdsLayer;


Birdy b;

Animation birdAnim;

void setup(){  
  background(255);  
  size(500,500);
  
  birdsLayer = createGraphics(width,height);
  
  birdAnim = new Animation(birdsLayer,"bird_color_green",2,
    width/2,0, 
    0.0, 1.5f, 
    50, 50);
//  birdsPool.add(birdAnim); 
  
//  for(int i=0; i<=5 ; i++){
//     birds.add(new Birdy(this,100,0.0,0.005f)); 
//  }
  b = new Birdy(width/2,0.0f,0.1f);
  b.loop();
  gravity = new PVector(0, 0.007f);
  wind = new PVector(0.0, 0); 
}


void draw(){
  background(255);
  
    for (Balloon balloon: helloBalloons) {
    balloon.update();
    if (balloon.checkEdges()) {
      helloBalloons.remove(balloon);
      Balloon b = new Balloon(random(0,width), 0.0f, 0.0005f);
      helloBalloons.add(b);
      wind.set(0.0,0.0);
      break;
    }
    balloon.display();
    balloon.applyForce(gravity);
    balloon.applyForce(wind);
    
  }

//    birdy.play();
      birdsLayer.beginDraw();
      birdsLayer.background(255,0);
      birdAnim.update();
      birdAnim.display();
//      b.update();
//      b.display();
      birdsLayer.endDraw();
    
//    image(b.getGifAnimation(), 100,100,50,50);

  
    if (syncOn){
      wind.set(wind.x,0.01f);
      syncOn = false;
    }
    image(birdsLayer,0,0);
}
 



public void mouseClicked() {
  Balloon b = new Balloon(mouseX, 0.0f, 0.0005f);
  helloBalloons.add(b);
  
}


void keyPressed() {
  println("keyPressed="+key);

    if (key == 'z') {
      wind.add(0.005f,0,0);
      frameCountLeft = frameCount;
    } else if (key == 'x') {
      wind.sub(0.005f,0.0f,0);
      frameCountRight = frameCount;
    } else if (key == 'b') {
      wind.set(0.0f,0.0f);
    } else if (key == 'B') {
//      Birdy b = birds.get(i);
//      b.update();
//      i++;
//      i = i % 5;
    } 
    
    if ( (Math.abs(frameCountLeft - frameCountRight)<2)){
      wind.set(0.0f,-0.03f);
      syncOn = true;
    }
}


public void windChanges() {
  float windChange = noise(xoff);
  xoff = xoff + 0.01f;
  wind.set(windChange*0.09f, 0.0f, 0.0f);
}



