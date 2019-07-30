PImage[] sprites;



void setup() {
  size(1500, 500);
  loadSprites();
}

void draw() {
  
  for (int x = 0; x < 7; x++)
    image(sprites[x], x * 181, 0, sprites[x].width, sprites[x].height);
    
  
}

public void loadSprites() {
   
  int spw = 181;
  int sph = 229;
  sprites = new PImage[7];
  
  PImage spriteSheet;
  spriteSheet = loadImage("animatedNanonaut.png");
  
  for (int x = 0; x < 7; x++) {
    int row = floor(x / 5);
    int x_coord = ((x-(row*5)) * spw);
    int y_coord = (row * sph);
    
    sprites[x] = spriteSheet.get(x_coord, y_coord, spw, sph);

  }
  
  spriteSheet = null;

}
