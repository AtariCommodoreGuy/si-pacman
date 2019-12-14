class Bawndingbawx {
  
  int top;
  int bottom;
  int left;
  int right;
  int size;
  
  Bawndingbawx(int x, int y, int size) {
    
    this.size = size;
    
  }
  
  void update(int x, int y) {
    
    left = x;
    right = x + size;
    top = y;
    bottom = y + size;
    
    if (show_boxes) {
      noFill();
      stroke(255, 0, 0);
      rect(x, y, size, size);
    }
    
  }
  boolean is_colliding(int x, int y) {
    
    if(x < this.left)
      return false;
      
    if (x > this.right)
      return false;
      
    if (y < this.top)
      return false;
      
    if (y > this.bottom)
      return false;
      
    return true;
  }
  
  boolean is_colliding(Bawndingbawx boks) {
    
    if(boks.right < this.left)
      return false;
    if(boks.left > this.right)
      return false;
    if(boks.top < this.bottom)
      return false;
    if(boks.bottom > this.top)
      return false;
    
    return true;
    
  }
  
}
