class Frufo {
  
  int x = -16;
  int y = 17;
  int froof_sprite_num;
  int dx = 1;
  int frooframe = 0;
  boolean is_alive = true;
  boolean is_on_screen = true;
  Bawndingbawx froof_box = new Bawndingbawx(0, 0, 32);
  
  Frufo() {
    
    froof_sprite_num = int (random(0, 5));
    
  }
  
  void update() {
    
    image(fruit[froof_sprite_num], x, y, 32, 32);
    x += dx;
    
    is_on_screen = x < screen_width;
    
    frooframe++;
    
    if (frooframe > 7) {
      froof_sprite_num = int (random(0, 5));
      frooframe = 0;
    }
    
    froof_box.update(x, y);    
  }  
  
}
