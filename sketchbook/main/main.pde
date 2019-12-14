PImage[] ghosts;
PImage[] fruit;
PImage[] pacman;
PImage[] pacman_death;
PImage pellet;

boolean show_boxes = false;

ArrayList<Bigbullet> pellets = new ArrayList<Bigbullet>();

int framerate = 60;
int screen_width = 500;
int screen_height = 500;
Frufo froof = null;

float frufo_p = 10.0;

int frame_count = 0;
int frame_update = 29;
int bullet_frame = 29;

int sprite_num = 0;
GhostRow[] rows;

Pacmanboiz chompyyellowball = new Pacmanboiz();

void setup() {
  size(500, 500);
  frameRate(60);
  
  ghosts = loadSprites("ghosts.png", 24, 6);
  fruit = loadSprites("pacman_fruit.png", 5, 5);
  pacman = loadSprites("pacman.png", 4, 4);
  pacman_death = loadSprites("pacman_death.png", 12, 12);
  pellet = loadSprites("pellet.png", 1, 1)[0];
  
  rows = new GhostRow[4];
  rows[0] = new GhostRow(ghosts, 0, 50, 50, 11);
  rows[1] = new GhostRow(ghosts, 6, 50, 50+40, 11);
  rows[2] = new GhostRow(ghosts, 12, 50, 50+80, 11);
  rows[3] = new GhostRow(ghosts, 18, 50, 50+120, 11);
  
}

void draw() {

  background(0, 0, 0);

  //update ghost positions and frufo
  if (frame_count == frame_update) {

    draw_ghosts();
    
    if (froof == null)
      generate_frufo();

  } else
    frame_count++;
  
  //refresh the ghosts onscreen
  for(int i = 0; i < 4; i++)
    rows[i].refresh();

  //update froof
  if (froof != null) {
    froof.update();
    
    if (!froof.is_on_screen)
      froof = null;
  }
  
  //update pacman
  chompyyellowball.update();
  
  //update bullets
  for(int i = 0; i < pellets.size(); i++)
    pellets.get(i).update();

  bullet_frame++;
  
  if(pellets.size() == 0)
    return;

  if(pellets.get(0).y < 0)
    pellets.remove(0);
    
  //collsion testing
  for(int i = 0; i < pellets.size(); i++) {
    
    Bigbullet pellet = pellets.get(i);
    
    if(froof!=null) {
      if(froof.froof_box.is_colliding(pellet.x, pellet.y)) {
        froof = null;
        pellets.remove(i);
        continue;
      }  
    }
    for(int j = 0; j < rows.length; j++)
      if(rows[j].ghost_heaven(pellet.x, pellet.y)) {
        pellets.remove(i);
        break;
      }
  }
}

public void generate_frufo() {
  
  int chance = int(random(0, frufo_p));
  
  if (chance > 1)
    return;
  
  froof = new Frufo();  
  
}

public void draw_ghosts() {
  
  frame_count = 0;
  
  boolean move_down = false;
  
  for(int i = 0; i < 4; i++) {

    rows[i].set_direction(false);
    
    if (rows[i].is_moving_down) {
      move_down = true;
      break;
    }    
  }
 
  for(int i = 0; i < 4; i++) {
    
    if (move_down)
      rows[i].set_direction(move_down);

    rows[i].update();
    
  }
  
  if (move_down)
    frame_update--;


}

public void drawSprites(PImage[] sprites, int start_row) {
  
  for(int x = 0; x < sprites.length; x++)
    image(sprites[x], x * 32, start_row * 32, 32, 32);
}

public PImage[] loadSprites(String filename, int sprite_count, int sprites_per_row) {
   
  int spw = 16;
  int sph = 16;
  PImage[] sprites = new PImage[sprite_count];
  
  PImage spriteSheet;
  spriteSheet = loadImage("sprites/" + filename);
  
  for (int x = 0; x < sprite_count; x++) {
    int row = floor(x / sprites_per_row);
    int x_coord = ((x-(row*sprites_per_row)) * spw);
    int y_coord = (row * sph);

    sprites[x] = spriteSheet.get(x_coord, y_coord, spw, sph);

  }
  
  spriteSheet = null;
  return sprites;
}

void keyPressed() {
  
  if (key == CODED) {
    
    if (keyCode == LEFT) {
      chompyyellowball.move(false);
    } else if (keyCode == RIGHT) {
      chompyyellowball.move(true);
    }
    return;
  } 
  
  if (key == ' ') {
    if(bullet_frame > 29) {
      pellets.add(new Bigbullet(chompyyellowball.x + 11, chompyyellowball.y));
      bullet_frame = 0;
    }
  } else if (key == 'b') {
    this.show_boxes = !this.show_boxes;
  }  
}
