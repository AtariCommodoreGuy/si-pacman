class Pacmanboiz {
  
  int x = screen_width/2;
  int y = screen_height-37;
  int pacman_sprite_num = 0;
  int dx = 4;
  int pacframe = 0;
  boolean is_alive = true;
  Bawndingbawx pac_box = new Bawndingbawx(0, 0, 32);
  
  Pacmanboiz() {
        
  }
  
  void update() {
    
    image(pacman[pacman_sprite_num], x, y, 32, 32);
    
    pacframe++;
    
    if (pacframe > 7) {
      pacman_sprite_num++;
      pacframe = 0;
      
      if (pacman_sprite_num > 3)
        pacman_sprite_num = 0;
    }
    
    pac_box.update(x, y);
        
  }
  
  void move(boolean moveRight) {
  
    if(moveRight) {
      if (x+dx <= screen_width-37)
        x += dx;
    }
    else if (x-dx >= 5)
        x -= dx;
      
  }
  
}
