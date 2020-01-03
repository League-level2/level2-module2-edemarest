//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;
  
  public Segment(int x, int y) {
    this.x = x;
    this.y = y;
  }

// Add a constructor with parameters to initialize each variable.



}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
   int foodX;
   int foodY;
   int direction = UP;
   int piecesEaten;
   Segment head;
   ArrayList<Segment> segments = new ArrayList<Segment>();




//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500, 500);
  head = new Segment(400, 400);
  frameRate(20);
  dropFood();
}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(#65E398);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(#985812);
  rect(foodX, foodY, 15, 15);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#00673D);
  rect(head.x, head.y, 15, 15);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for(Segment s: segments) {
      fill( random(255), random(255), random(255), random(255));
      rect(s.x, s.y, 15, 15);
  }
  
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  segments.add(new Segment(head.x, head.y));
  segments.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(Segment s: segments) {
    if(s.x == head.x && s.y == head.y) {
      piecesEaten = 0;
      segments = new ArrayList<Segment>();
      drawTail();
      segments.add(new Segment(head.x, head.y));
    }
  } 
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (key == CODED) {
    if (keyCode == UP && direction != DOWN) {
      direction = UP;
    } 
    else if (keyCode == DOWN && direction != UP) {
      direction = DOWN;
    }
    else if (keyCode == RIGHT && direction != LEFT) {
      direction = RIGHT;
    }
    else if(keyCode == LEFT && direction != RIGHT) {
      direction = LEFT;
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
    
    
  switch(direction) {
  case UP:
    head.y -= 5;
    // move head up here 
    break;
  case DOWN:
    head.y += 5;
    // move head down here 
    break;
  case LEFT:
    head.x -= 5;
   // figure it out 
    break;
  case RIGHT:
    head.x += 5;
    // mystery code goes here 
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.x == width){
   head.x = 1;
 }
 else if(head.x == 0){
   head.x = width;
 }
 else if(head.y == height) {
   head.y = 1;
 }
 else if(head.y == 0) {
   head.y = height;
 }
 
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if(head.x == foodX && head.y == foodY) {
    piecesEaten++;
    print(piecesEaten);
    dropFood();
    drawTail();
    segments.add(new Segment(head.x, head.y));
  }
}
