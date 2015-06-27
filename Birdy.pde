

class Birdy {
  
   GifAnimation birdy; 

   PVector location, velocity, acceleration;    
  
   Birdy(float x, float vx, float vy){
//     super(ref,"bird_color2.gif"); 
     location = new PVector(x,0);
     velocity = new PVector(vx,vy);
     acceleration = new PVector(0.0,0.0);
     birdy = new GifAnimation(skygame.this,"bird_color2.gif");
   }

  public void loop(){
     birdy.loop(); 
  }

   
  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    if (location.y >= height){
       location.y =0;
//       birdy.pause();  
    }
  }
  
  public void display(){
     birdsLayer.image(birdy,location.x,location.y,50,50); 
  }
  
  public void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  public GifAnimation getGifAnimation(){
    return birdy;
  }

  public void reset(float x, float vy) {
    location.set(x,0);
    velocity.set(0.0,vy);
    acceleration.mult(0);
    birdy.loop();
  }
   
   
  public boolean checkEdges() {
//    return false;
    if (location.y >= height) {
      return true;
    }    
    if (location.x >= width ) {
      velocity.x *= -1.0f;      
      return false;
    }
    if (location.x <= 0) {
      velocity.x *= -1.0f;      
      return false;
    }
    return false;
  }
  

     
     
  
  
}
