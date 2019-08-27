class Frufo {
  
  int x = -16;
  int y = 17;
  int froof_sprite_num;
  int dx = 1;
  
  Frufo() {
    
    froof_sprite_num = int (random(0, 6));
    
  }
  
  void update() {
    
    image(fruit[froof_sprite_num], x, y, 32, 32);
    x += dx;
    
  }  
  
}
