import processing.sound.*;
SoundFile file;
PImage sky;
PImage house;
PImage galFull;
float a = 395;
float b = 495;
float c = 570;
float d = 200;
float spdA = 0.15;
float spdB = -0.15;
float armSpeedX = 1;
boolean openDoor = false;
boolean goLeft = false;
boolean homeScreen = false;

float offsetX = -900;
float targetOffsetX = -900;
float lerpFactor = 0.1;

void setup() {  
  size(900, 800);
  sky = loadImage("sky.png");
  sky.resize(900, 800);
  house = loadImage("house.png");
  house.resize(900, 800);
  galFull = loadImage("gall.png");
  galFull.resize(1800, 800);
  file = new SoundFile(this, "music.mp3");
  file.play();
}

void draw() {
  if (homeScreen) {
    drawHome();
    
  } else {
    if (openDoor) {
      drawGallery();
      
      if (mousePressed && mouseX > 850) {
        homeScreen = true;
        openDoor = false;
      }

    } else {
      drawHome();
    }
  }
}



// other methods
void drawHome() {
  image(sky, 0, 0);
  drawSun();
  image(house, 0, 0);
    
  drawFrog(mouseX, mouseY);
    
  if (mouseX >= 620 && mouseX <= 680 && mouseY >= 450 && mouseY <= 550
      && mousePressed) {
    homeScreen = false;
    openDoor = true;
  }
}

void drawGallery() {
  background(255);
  offsetX = lerp(offsetX, targetOffsetX, lerpFactor);
  image(galFull, offsetX, 0);
  drawFrog(mouseX, mouseY);

  if (mouseX >= 600) {
    targetOffsetX = -900;
  } else if (mouseX > 300) {
    targetOffsetX = map(mouseX, 300, 600, 0, -900);
  } else {
    targetOffsetX = 0;
  }
}

void drawFrog(float frogX, float frogY) {
  // Frog body
  fill(114, 194, 133);
  ellipse(frogX, frogY, 150, 120);
  ellipse(frogX - 50, frogY - 50, 50, 50);
  ellipse(frogX + 50, frogY - 50, 50, 50);
  rect(frogX - 25, frogY + 20, 10, 150);
  rect(frogX + 15, frogY + 20, 10, 150);

  // Frog blush
  fill(255, 192, 203);
  ellipse(frogX - 45, frogY - 20, 25, 15);
  ellipse(frogX + 45, frogY - 20, 25, 15);

  // Frog eyes and mouth
  fill(0);
  ellipse(frogX - 50, frogY - 50, 25, 25);
  ellipse(frogX + 50, frogY - 50, 25, 25);
  ellipse(frogX, frogY - 30, 28, 2);

  // Shoes
  fill(107, 65, 42);
  rect(frogX + 12, frogY + 170, 40, 20, 20);
  rect(frogX + 12, frogY + 150, 20, 35, 20);
  rect(frogX - 50, frogY + 170, 40, 20, 20);
  rect(frogX - 30, frogY + 150, 20, 35, 20);

  // Arms
  fill(114, 194, 133);
  stroke(114, 194, 133);
  strokeWeight(9);
  line(frogX - 115, frogY + 50, frogX - 65, frogY - 10);
  line(frogX + 100, frogY + 10, frogX + 65, frogY - 10);
  line(frogX + (c - 450), frogY - 50, frogX + 100, frogY + 10);

  // Moving eyes
  fill(255);
  noStroke();
  ellipse(frogX - 50 + (a - 400), frogY - 52, 10, 10);
  ellipse(frogX + 50 + (b - 500), frogY - 52, 10, 10);

  // Update animation variables
  a += spdA;
  b += spdB;
  c += armSpeedX;

  if (a <= 394.95 || a >= 405) spdA *= -1;
  if (b <= 494.95 || b >= 505) spdB *= -1;
  if (c > 580 || c < 560) armSpeedX *= -1;
}


void drawSun() {
  // Move the circle in an arc
  float yArc = 300 + 100 * sin(radians(d));
  for (int i = 1; i < 8; i+=2) {
    fill(255-7*i, 192-7*i, 203-7*i);
    ellipse(d, yArc, 150-15*i, 150-15*i);
  }
  d += 1.5; 
}
