// Import the repository.
import fisica.*;

// Declare a reference to the repository.
FWorld world;

void setup() {
  size(800, 400);
  smooth();

  // Initialize the repository.
  // View: http://www.ricardmarxer.com/fisica/reference/fisica/Fisica.html
  Fisica.init(this);

  // Create a reference to the repository.
  // View: http://www.ricardmarxer.com/fisica/reference/fisica/FWorld.html
  world = new FWorld();
  // Enable gravity (x, y).
  world.setGravity(0, 100);
  // Enable the perimeter walls of the stage.
  world.setEdges();

  // Create new body.left
  // View: http://www.ricardmarxer.com/fisica/reference/fisica/FBox.html
  FBox torso = new FBox(40, 80);
  torso.setPosition(width/2, height/2);
  torso.setStroke(255, 0, 0);
  torso.setFill(255, 0, 0);
  world.add(torso);

  FBox armL = new FBox(10, 80);
  armL.setPosition(width/2-(torso.getWidth()+armL.getWidth())/2, height/2);
  armL.setFill(123, 64, 45);
  armL.setStroke(123, 64, 45);
  world.add(armL);

  FBox armR = new FBox(10, 80);
  armR.setPosition(width/2+(torso.getWidth()+armL.getWidth())/2, height/2);
  armR.setFill(123, 64, 45);
  armR.setStroke(123, 64, 45);
  world.add(armR);

  FCircle head = new FCircle(40);
  head.setPosition(width/2, height/2-(torso.getHeight()+head.getSize())/2);
  head.setFill(0);
  head.setStroke(0);
  world.add(head);

  FBox thighL = new FBox(10, 40);
  thighL.setPosition(width/2-(torso.getWidth()-thighL.getWidth())/2, height/2+torso.getHeight());
  thighL.setFill(123, 64, 45);
  thighL.setStroke(123, 64, 45);
  world.add(thighL);

  FBox thighR = new FBox(10, 40);
  thighR.setPosition(width/2+(torso.getWidth()-thighL.getWidth())/2, height/2+torso.getHeight());
  thighR.setFill(123, 64, 45);
  thighR.setStroke(123, 64, 45);
  world.add(thighR);
  
  FBox calfL = new FBox(10,40);
  calfL.setPosition(width/2-(torso.getWidth()-calfL.getWidth())/2, height/2+torso.getHeight()+thighL.getHeight());
  calfL.setFill(123, 64, 45);
  calfL.setStroke(123, 64, 45);
  world.add(calfL);
  
  FBox calfR = new FBox(10,40);
  calfR.setPosition(width/2+(torso.getWidth()-calfR.getWidth())/2, height/2+torso.getHeight()+thighR.getHeight());
  calfR.setFill(123, 64, 45);
  calfR.setStroke(123, 64, 45);
  world.add(calfR);
  
  //FBox footL = new FBox();
  //footL.setPosition(width/2+(torso.getWidth()+thighL.get

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

  FDistanceJoint jointTorsothighL = new FDistanceJoint(torso, thighL);
  jointTorsothighL.setLength(0);
  jointTorsothighL.setAnchor1(-20, 40);
  jointTorsothighL.setAnchor2(-5, -40);

  FDistanceJoint jointTorsothighR = new FDistanceJoint(torso, thighR) ;
  jointTorsothighR.setLength(0);
  jointTorsothighR.setAnchor1(20, 40);
  jointTorsothighR.setAnchor2(5, -40);

  //Construct a revolute joint between two bodies given an anchor position.
  world.add(jointTorsoArmL);
  world.add(jointTorsoArmR);
  world.add(jointTorsoHead);
  world.add(jointTorsothighL);
  world.add(jointTorsothighR);
}

void draw() {
  background(100);
  // Execute a step of the simulation
  world.step();
  // Draw the simulation
  world.draw(this);
}

