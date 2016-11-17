int time = 0;
boolean leRotatingLeft = false;
boolean leRotatingRight = false;
boolean leAccelerate = false;
boolean leShooting = false;
SpaceShip shuu = new SpaceShip();
Star[] spacesky = new Star[200];
ArrayList<Asteroid> comets = new ArrayList<Asteroid>();
ArrayList<Bullet> nyaa = new ArrayList<Bullet>();
public void setup() 
{
  size(600,600, P2D);
  for(int i = 0; i < spacesky.length; i = i + 1){
    spacesky[i] = new Star();
  }
  for(int i = 0; i < 10; i = i + 1){
    comets.add(new Asteroid());}
}
public void draw() 
{ 
  background(0);
  for(int i = 0; i < spacesky.length; i = i + 1){
    spacesky[i].show();
  }
  for(int nI = 0; nI < nyaa.size(); nI = nI + 1) {
    nyaa.get(nI).show();
    nyaa.get(nI).move();
  }
  for(int nI = 0; nI < comets.size(); nI = nI + 1){
    comets.get(nI).show();
    comets.get(nI).move();
  }

  shuu.show();
  shuu.move();
  if(leAccelerate == true){shuu.accelerate(.1);}
  if(leRotatingLeft == true){shuu.rotate(-5);}
  if(leRotatingRight == true){shuu.rotate(5);}
  if(leShooting == true){nyaa.add(new Bullet(shuu));}
  time = time + 1;
    for(int nI = comets.size() - 1; nI >= 0; nI = nI - 1){
    for(int nO = nyaa.size() - 1; nO >= 0; nO = nO - 1){
       if(dist(nyaa.get(nO).getX(), nyaa.get(nO).getY(), comets.get(nI).getX(), comets.get(nI).getY()) < 10){
       comets.remove(nI);
        nyaa.remove(nO);
        break;
      }
    }
  }
  if(time % 60 == 0){
    comets.add(new Asteroid());
  }
text("myCenterX: "+ shuu.getX(),10,20);
  text("myCenterY: "+ shuu.getY(),10,40);
  text("myPointDirection: "+ shuu.getPointDirection(),10,60);
  text("myDirectionX: "+ (int)(shuu.getDirectionX()*100)/100.0,10,80);
  text("myDirectionY: "+ (int)(shuu.getDirectionY()*100)/100.0,10,100);
}


public void keyPressed()
{
  if(key == 'z' || key == 'Z')
  {
    shuu.setDirectionX(0);
    shuu.setDirectionY(0);
    shuu.setX((int)(Math.random()*501));
    shuu.setY((int)(Math.random()*501));
    shuu.setPointDirection((int)(Math.random()*361));
  }
  if(key == 'x' || key == 'X')
  {
    leShooting = true;
  }
  if(key == 'j' || key == 'J')
  {
    leRotatingLeft = true;
  }
  if(key == 'k' || key == 'K')
  {
    leAccelerate = true;
  }
  if(key == 'l' || key == 'L')
  {
    leRotatingRight = true;
  }
}
public void keyReleased() {
  leRotatingRight = false;
  leRotatingLeft = false;
  leAccelerate = false;
  leShooting = false;
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
class SpaceShip extends Floater  
{
  SpaceShip(){
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 12;
    yCorners[0] = 0;
    xCorners[1] = 0;
    yCorners[1] = -12;
    xCorners[2] = -3;
    yCorners[2] = -3;
    xCorners[3] = -12;
    yCorners[3] = 0;
    xCorners[4] = -3;
    yCorners[4] = 3;
    xCorners[5] = 0;
    yCorners[5] = 12;
    myColor = color(255, 255, 255);
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
    public void setX(int x){myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX = x;}
    public double getDirectionX(){return myDirectionX;}
    public void setDirectionY(double y){myDirectionY = y;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection = degrees;}
    public double getPointDirection(){return myPointDirection;}
}
class Asteroid extends Floater
{
  private int rotationSpeed;
  Asteroid(){
    corners = 11;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 0;
    yCorners[0] = -9;
    xCorners[1] = 4;
    yCorners[1] = -8;
    xCorners[2] = 7;
    yCorners[2] = -4;
    xCorners[3] = 9;
    yCorners[3] = 0;
    xCorners[4] = 5;
    yCorners[4] = 5;
    xCorners[5] = 1;
    yCorners[5] = 6;
    xCorners[6] = -5;
    yCorners[6] = 5;
    xCorners[7] = -6;
    yCorners[7] = 2;
    xCorners[8] = -8;
    yCorners[8] = -1;
    xCorners[9] = -6;
    yCorners[9] = -6;
    xCorners[10] = -3;
    yCorners[10] = -6;
    myColor = color(190, 190, 190);
    myCenterX = (int)(Math.random()*501);
    myCenterY = (int)(Math.random()*501);
    myDirectionX = Math.random()*2 - 1;
    myDirectionY = Math.random()*2 - 1;
    myPointDirection = 0;
    rotationSpeed = (int)(Math.random()*5) - 2;
  }
    public void setX(int x){myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX = x;}
    public double getDirectionX(){return myDirectionX;}
    public void setDirectionY(double y){myDirectionY = y;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection = degrees;}
    public double getPointDirection(){return myPointDirection;}
    public void move(){
      rotate(rotationSpeed);
      super.move();
    }
}

class Star
{
  private int myX, myY;
  Star(){
    myX = (int)(Math.random()*601);
    myY = (int)(Math.random()*601);
  }
  public void show(){
    fill(255, 255, 0);
    ellipse(myX, myY, 2, 2);
  }
}