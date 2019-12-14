class Bigbullet {
  
  int pellet_speed = 5;
  int x;
  int y;
  int dy = 1;

  Bigbullet(int x, int y) {
    
    this.x = x;
    this.y = y;
    
  }
  
  void update() {
    
    image(pellet, this.x, this.y, 16, 16);
    y -= dy;
  
  }

}
