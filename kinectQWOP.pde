import damkjer.ocd.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Camera cameron;

boolean david;
boolean wesley; //create game
Minim dj;
AudioPlayer breakNeck;
float distance;

PFont font;


//!!!!!(Cameron sucks);
//http://www.ricardmarxer.com/fisica/reference/index.html

// Import the repository.
import fisica.*;

// Declare a reference to the repository.
FWorld world;
FBox floor, footL, footR, calfL, calfR, thighL, thighR, armL, armR, torso;
FCircle head;

final int minWin = 0;
final int maxWin = 10300;

void setup() {
  wesley = false;
  david = false;
  distance = 0;
  dj = new Minim(this);
  breakNeck = dj.loadFile("neckSnap.wav");
  size(800, 400,P3D);
  background(100);
  smooth();

  font = loadFont("LucidaBright-48.vlw");
  textFont(font, 48);
  textAlign(CENTER);

  // Initialize the repository.
  // View: http://www.ricardmarxer.com/fisica/reference/fisica/Fisica.html
  Fisica.init(this);

  // Create a reference to the repository.
  // View: http://www.ricardmarxer.com/fisica/reference/fisica/FWorld.html
  world = new FWorld(0,0,10300,height);
  // Enable gravity (x, y).
  world.setGravity(0, 100);
  // Enable the perimeter walls of the stage.

  createGame();
  cameron = new Camera(this,width/2,height/2,336, width/2, height/2, 0);

}

void draw() {
  background(100);
  if(!wesley)    //title screen
    {
      fill(0);
      rect(0,0,width,height);
      fill(255);
      text("Kinect QWOP", width/2,height/5);
      text("Press 'S' to begin", width/2, height/5 * 3);
      
    }
  // Execute a step of the simulation
  else //the game n stuff
  {
  world.step();
  // Draw the simulation
  world.draw(this);
  distance = torso.getX()-width/2;
  distance = map(distance,-width/2,width/2,-3,3);
  String dist = distance + "";
  dist = dist.substring(0,dist.indexOf(".")+2);
  text(dist+" m",width/2, height/5);
  
   cameron.truck(width/2-torso.getX());
  
  cameron.feed();
  if (head.isTouchingBody(floor) || armL.isTouchingBody(floor) || armR.isTouchingBody(floor))
    endGame();
  }
}

void keyPressed() {
  if(keyCode == 83){ //s
    wesley = true;
  }
  if (keyCode == 81) { //Q
    thighL.addImpulse(40, 40);
    calfL.addTorque(20);
  } 
  if (keyCode == 87) { //W
    thighR.addImpulse(40, 40);
    calfR.addTorque(20);
  }
  if (keyCode == 79) { //O
    calfR.addImpulse(40, 40);
    footR.addImpulse(40, 40);
  } 
  if (keyCode == 80) { //P
    calfL.addImpulse(40, 40);
    footL.addImpulse(40, 40);
  }
  if (keyCode == 32) { //Spacebar
    resetGame();
  }
}

void createGame() {  
  //world.setEdges();
  floor = new FBox(width*10, 2);
  floor.setPosition(width/2, height-5);
  floor.setStatic(true);
  floor.setGrabbable(false);
  world.add(floor);
  // Create new body.left
  // View: http://www.ricardmarxer.com/fisica/reference/fisica/FBox.html
  footL = new FBox(25, 10);
  footL.setPosition((width-40+footL.getWidth())/2, height-footL.getHeight()/2-10);
  footL.setFill(255);
  footL.setStroke(255);
  footL.setFriction(10);
  footL.setGroupIndex(-2);
  world.add(footL);

  footR = new FBox(25, 10);
  footR.setPosition((width+40-footR.getWidth())/2, footL.getY()-10);
  footR.setFill(255);
  footR.setStroke(255);
  footR.setFriction(10);
  footR.setGroupIndex(-2);
  world.add(footR);

  calfL = new FBox(10, 40);
  calfL.setPosition((width-40+calfL.getWidth())/2, height-footL.getHeight()-calfL.getHeight()/2-10);
  calfL.setFill(123, 64, 45);
  calfL.setStroke(123, 64, 45);
  calfL.setFriction(10);
  calfL.setGroupIndex(-2);
  world.add(calfL);

  calfR = new FBox(10, 40);
  calfR.setPosition((width+40-calfR.getWidth())/2, calfL.getY()-10);
  calfR.setFill(123, 64, 45);
  calfR.setStroke(123, 64, 45);
  calfR.setFriction(10);
  calfR.setGroupIndex(-2);
  world.add(calfR);

  thighL = new FBox(10, 40);
  thighL.setPosition(calfL.getX(), height-footL.getHeight()-calfL.getHeight()-thighL.getHeight()/2-10);
  thighL.setFill(123, 64, 45);
  thighL.setStroke(123, 64, 45);
  thighL.setFriction(10);
  thighL.setGroupIndex(-3);
  world.add(thighL);

  thighR = new FBox(10, 40);
  thighR.setPosition(calfR.getX(), thighL.getY()-10);
  thighR.setFill(123, 64, 45);
  thighR.setStroke(123, 64, 45);
  thighR.setFriction(10);
  thighR.setGroupIndex(-3);
  world.add(thighR);

  armL = new FBox(10, 80);
  armL.setPosition((width-40-armL.getWidth())/2, height-footL.getHeight()-calfL.getHeight()-thighL.getHeight()-armL.getHeight()/2-10);
  armL.setFill(123, 64, 45);
  armL.setStroke(123, 64, 45);
  world.add(armL);

  armR = new FBox(10, 80);
  armR.setPosition((width+40+armR.getWidth())/2, armL.getY()-10);
  armR.setFill(123, 64, 45);
  armR.setStroke(123, 64, 45);
  world.add(armR);

  torso = new FBox(40, 80);
  torso.setPosition(width/2, armL.getY()-10);
  torso.setStroke(255, 0, 0);
  torso.setFill(255, 0, 0);
  torso.setFriction(10);
  world.add(torso);

  head = new FCircle(40);
  head.setPosition(width/2, height-footL.getHeight()-calfL.getHeight()-thighL.getHeight()-torso.getHeight()-head.getSize()/2-10);
  head.setFill(0);
  head.setStroke(0);
  world.add(head);

  FDistanceJoint jointTorsoArmL = new FDistanceJoint(torso, armL);
  jointTorsoArmL.setLength(0);
  jointTorsoArmL.setAnchor1(-20, -40);
  jointTorsoArmL.setAnchor2(5, -40);

  FDistanceJoint jointTorsoArmR = new FDistanceJoint(torso, armR) ;
  jointTorsoArmR.setLength(0);
  jointTorsoArmR.setAnchor1(20, -40);
  jointTorsoArmR.setAnchor2(-5, -40);

  FDistanceJoint jointTorsoHead = new FDistanceJoint(torso, head) ;
  jointTorsoHead.setLength(0);
  jointTorsoHead.setAnchor1(0, -40);
  jointTorsoHead.setAnchor2(0, 20);

  FDistanceJoint jointTorsoThighL = new FDistanceJoint(torso, thighL);
  jointTorsoThighL.setLength(0);
  jointTorsoThighL.setAnchor1(-torso.getWidth()/2+thighL.getWidth()/2, torso.getHeight()/2);
  jointTorsoThighL.setAnchor2(0, -thighL.getHeight()/2);

  FDistanceJoint jointTorsoThighR = new FDistanceJoint(torso, thighR) ;
  jointTorsoThighR.setLength(0);
  jointTorsoThighR.setAnchor1(torso.getWidth()/2-thighR.getWidth()/2, torso.getHeight()/2);
  jointTorsoThighR.setAnchor2(0, -thighR.getHeight()/2);

  FDistanceJoint jointThighCalfL = new FDistanceJoint(thighL, calfL);
  jointThighCalfL.setLength(0);
  jointThighCalfL.setAnchor1(-thighL.getWidth()/4, thighL.getHeight()/2);
  jointThighCalfL.setAnchor2(-calfL.getWidth()/4, -calfL.getHeight()/2);

  FDistanceJoint jointThighCalfR = new FDistanceJoint(thighR, calfR);
  jointThighCalfR.setLength(0);
  jointThighCalfR.setAnchor1(-thighR.getWidth()/4, thighR.getHeight()/2);
  jointThighCalfR.setAnchor2(-calfR.getWidth()/4, -calfR.getHeight()/2);
  //jointThighCalfR.setDamping(0);
  jointThighCalfR.setFrequency(10);

  FDistanceJoint jointCalfFootL = new FDistanceJoint(calfL, footL);
  jointCalfFootL.setLength(0);
  jointCalfFootL.setAnchor1(calfL.getWidth()/2, calfL.getHeight()/2);
  jointCalfFootL.setAnchor2(0, -footL.getHeight()/2);

  FDistanceJoint jointCalfFootR = new FDistanceJoint(calfR, footR);
  jointCalfFootR.setLength(0);
  jointCalfFootR.setAnchor1(calfR.getWidth()/2, calfR.getHeight()/2);
  jointCalfFootR.setAnchor2(0, -footR.getHeight()/2);

  FDistanceJoint jointCalfFootL2 = new FDistanceJoint(calfL, footL);
  jointCalfFootL2.setLength(0);
  jointCalfFootL2.setAnchor1(-calfL.getWidth()/2, calfL.getHeight()/2);
  jointCalfFootL2.setAnchor2(-calfL.getWidth(), -footL.getHeight()/2);

  FDistanceJoint jointCalfFootR2 = new FDistanceJoint(calfR, footR);
  jointCalfFootR2.setLength(0);
  jointCalfFootR2.setAnchor1(-calfR.getWidth()/2, calfR.getHeight()/2);
  jointCalfFootR2.setAnchor2(-calfR.getWidth(), -footR.getHeight()/2);

  //Construct a revolute joint between two bodies given an anchor position.
  world.add(jointTorsoArmL);
  world.add(jointTorsoArmR);
  world.add(jointTorsoHead);
  world.add(jointTorsoThighL);
  world.add(jointTorsoThighR);
  world.add(jointThighCalfL);
  world.add(jointThighCalfR);
  world.add(jointCalfFootL);
  world.add(jointCalfFootR);
  world.add(jointCalfFootL2);
  world.add(jointCalfFootR2);
}

void endGame() {  //freezes and displays score
  if (!david)
  {
    breakNeck.play();
    david = true;
  }
  for (Object o : world.getBodies ()){
    ((FBody)o).setStatic(true);
  }
}

void resetGame() {
  for (Object o : world.getBodies ())
    world.remove((FBody)o);
  david = false;
  breakNeck.rewind();  
  createGame();
}

