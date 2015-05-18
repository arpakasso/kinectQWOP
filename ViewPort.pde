

// the viewport  


class ViewPort {

  // this class provdides a viewport (camera view) for a 
  // tile map.  
  // to draw the map (2D array) you would say:
  // for (int x = lowerBoundCurrentX; x < upperBoundCurrentX; x++ ) {
  // for (int y = lowerBoundCurrentY; y < upperBoundCurrentY; y++ ) {
  // map[x,y].draw();
  // When the figure/player moves, lowerBoundCurrentX upperBoundCurrentX and
  // lowerBoundCurrentY and upperBoundCurrentY are moved. 

  // the outer borders (min and max values that are allowed) 

  int lowerBoundAbsoluteX = 0;
  int upperBoundAbsoluteX = 1110;

  int lowerBoundAbsoluteY = 0;
  int upperBoundAbsoluteY = 1110;

  // ------------------------

  // the currecnt viewport

  int lowerBoundCurrentX = 400;
  int upperBoundCurrentX = 500;

  int lowerBoundCurrentY = 400;
  int upperBoundCurrentY = 500;

  // ---------------------------------

  // the size of the viewport

  int widthViewPort = 50;
  int heightViewPort = 50;

  // ---------------------------------

  ViewPort(int a1, int a2, int b1, int b2) {

    // constructor

    lowerBoundAbsoluteX = a1;
    upperBoundAbsoluteX = a2;

    lowerBoundAbsoluteY = b1;
    upperBoundAbsoluteY = b2;

    // set current view port at center  
    lowerBoundCurrentX = ( (a1+a2) / 2) - widthViewPort / 2;
    upperBoundCurrentX = ( (a1+a2) / 2) + widthViewPort / 2;

    lowerBoundCurrentY = ( (b1+b2) / 2) - heightViewPort / 2;
    upperBoundCurrentY = ( (b1+b2) / 2) + heightViewPort / 2;

    //
  } // constructor 

  // ---------------------------------

  boolean moveLeft() {
    // moves the viewport left and returns true when this succeded 
    if (lowerBoundCurrentX>lowerBoundAbsoluteX)
    {
      lowerBoundCurrentX--;
      upperBoundCurrentX--;
      return true;
    } else {
      return false;
    } // else
  } // method

  boolean moveRight() {
    // moves the viewport right
    if (upperBoundCurrentX<upperBoundAbsoluteX)
    {
      lowerBoundCurrentX++;
      upperBoundCurrentX++;
      return true;
    } else {
      return false;
    } // else
  } // method

  boolean moveUp() {
    // moves the viewport up and returns true when this succeded 
    if (lowerBoundCurrentY>lowerBoundAbsoluteY)
    {
      lowerBoundCurrentY--;
      upperBoundCurrentY--;
      return true;
    } else {
      return false;
    } // else
  } // method

  boolean moveDown() {
    // moves the viewport down
    if (upperBoundCurrentY<upperBoundAbsoluteY)
    {
      lowerBoundCurrentY++;
      upperBoundCurrentY++;
      return true;
    } else {
      return false;
    } // else
  } // method
  //
} // class
//
//

