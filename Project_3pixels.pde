PImage natsu; 
PImage gajeel;

ArrayList<pixels> dots;
ArrayList<PVector> targets1, targets2;

int scaler = 4; 
int threshold = 210;

boolean imageToggled = false;
color col1, col2;

void setup() {
  size(75, 75, P2D);  
  
  natsu = loadImage("natsu.png");
  gajeel = loadImage("Gajeel.png");

  int w, h;
  if (natsu.width > gajeel.width) {
    w = gajeel.width;
  } 
  else {
    w = gajeel.width;
  }
 
  if (natsu.height > gajeel.height) {
    h = natsu.height;
  }
  else {
    h = gajeel.height;
  }
  surface.setSize(w, h);
  
  natsu.loadPixels();
  gajeel.loadPixels();
  
  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  
  col1 = color(#0347FF);
  col2 = color(#FF0303);
  
  for (int x = 0; x < gajeel.width; x += scaler) {
    
    for (int y = 0; y < gajeel.height; y += scaler) {
      int loc = x + y * gajeel.width;

      if (brightness(gajeel.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }

  dots = new ArrayList<pixels>();

  for (int x = 0; x < natsu.width; x += scaler) {
   
    for (int y = 0; y < natsu.height; y += scaler) {
      int loc = x + y * natsu.width;
      
      
      if (brightness(natsu.pixels[loc]) > threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        pixels dot = new pixels(x, y, col1, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() { 
  background(0);
  
  blendMode(ADD);
  
  boolean flipTargets = true;

  for (pixels dot : dots) {
    dot.run();
    
    if (!dot.ready) flipTargets = false;
  }
  
  if (flipTargets) {
   
    for (pixels dot : dots) {
      
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        dot.targ = targets1.get(targetIndex);
        dot.col = col2;
      }
      else {
        int targetIndex = int(random(0, targets2.size()));
        dot.targ = targets2.get(targetIndex);
        dot.col = col1;
      }
    }
    imageToggled = !imageToggled;
  }
    
  surface.setTitle("" + frameRate);
}
