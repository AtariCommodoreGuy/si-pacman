class GhostRow {
  
  PImage[] sprites;
  int x;
  int y;
  int cur_sprite = 0;
  int dx = 2;
  int dy = 16;
  int ghost_count;
  int row_length;
  int cell_width = 40;
  int frame_count = 0;
  int has_collided = 0;
  boolean is_moving_right = true;
  boolean is_moving_down = false;
  int downward_steps = 0;
  
  GhostRow(PImage[] sprite_list, int start_sprite, int start_x, int start_y, int count) {
    x = start_x; 
    y = start_y;
    row_length = cell_width * count;
    sprites = new PImage[6];
    ghost_count = count;
    
    for(int i = 0; i < 6; i++)
      sprites[i] = sprite_list[start_sprite + i]; 
  }
  
  boolean is_edge_collide() {
    
    if (x + row_length > screen_width)
      return true;
      
    if (x - 8 < 0)
      return true;
    
    return false;
  }
  
  void update() {
    
    this.set_direction();

    frame_count = 0;
  
    if (this.is_moving_down)
      this.moveDown();

    else if (this.is_moving_right)
      this.moveRight();
    
    else
      this.moveLeft(); //<>//
      
    for(int i = 0; i < ghost_count; i++) {  
      image(sprites[cur_sprite], x + i * 40, y, 32, 32);
      }      
  }
  
  void set_direction() {
    
    if (!this.is_moving_down) {

        if ((this.has_collided == 1 && this.is_moving_right) || (this.has_collided == -1 && !this.is_moving_right)) {
          this.is_moving_down = true;
          this.is_moving_right = !this.is_moving_right; 
        }
      }

    if (this.is_moving_down) {
    
      if (this.downward_steps > 0) {
        this.is_moving_down = false;
        this.downward_steps = 0;  
      }  
      else
        this.downward_steps++;
    }
    
  }
  void moveRight() {
    
    if (cur_sprite == 0)
      cur_sprite = 1;
    else
      cur_sprite = 0;
    
    x += dx;
    
    if (is_edge_collide())
      this.has_collided = 1;
    else
      this.has_collided = 0;
  }
  
   void moveLeft() {
    
    if (cur_sprite == 2)
      cur_sprite = 3;
    else
      cur_sprite = 2;
    
    x -= dx;
    
    if (is_edge_collide())
      this.has_collided = -1;
    else
      this.has_collided = 0;
  }
  
  void moveDown() {
    has_collided = 0;
    
    if (cur_sprite == 4)
      cur_sprite = 5;
    else
      cur_sprite = 4;
      
    y += dy;
    
  }
}
