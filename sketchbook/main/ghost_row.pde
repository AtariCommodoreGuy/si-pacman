class GhostRow {
  
  PImage[] sprites = new PImage[6];
  Bawndingbawx[] sprite_boxes = new Bawndingbawx[11];
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
    ghost_count = count;
    
    for(int i = 0; i < 6; i++) 
      sprites[i] = sprite_list[start_sprite + i];
      
    for (int i = 0; i < count; i++)
      sprite_boxes[i] = new Bawndingbawx(x + i * 40, y, 32);    
    
  }
  
  boolean is_edge_collide() {
    
    Bawndingbawx left_bawx = null;
    
    Bawndingbawx right_bawx = null;
    
    for(int i = 0; i < sprite_boxes.length; i++) {
      if (sprite_boxes[i] != null) {
        if (left_bawx == null)
          left_bawx = sprite_boxes[i];
        right_bawx = sprite_boxes[i];
      }
      
    }
    if (left_bawx == null)
      return false;
      println(right_bawx.right, screen_width);
    
    if (left_bawx.left < 5 && !this.is_moving_right)
      return true;
    
    if (right_bawx.right > screen_width-5 && this.is_moving_right)
      return true;
    
    return false;
  }
  
  void update() {

    frame_count = 0;
  
    if (this.is_moving_down)
      this.moveDown();

    else if (this.is_moving_right)
      this.moveRight();
    
    else
      this.moveLeft(); //<>//

  }
  
  void refresh() {
    
    for(int i = 0; i < ghost_count; i++) { 
      if (sprite_boxes[i] == null)
        continue;
      image(sprites[cur_sprite], x + i * 40, y, 32, 32);
      sprite_boxes[i].update(x + i * 40, y);
    }     
  }
  
  boolean ghost_heaven(int x, int y) {
    
    for(int i = 0; i < sprite_boxes.length; i++) {
      if (sprite_boxes[i] == null)
        continue;
      if (sprite_boxes[i].is_colliding(x, y)) {
        
        sprite_boxes[i] = null;
        return true;
      }
    }
    return false;
  }
  
  boolean has_collided() {
    
    return (this.has_collided == 1 && this.is_moving_right) || (this.has_collided == -1 && !this.is_moving_right);  
    
  }
 
  void set_direction(boolean force_down) {
    
    if (!this.is_moving_down) {

        
        
        if (collision || force_down) {
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
