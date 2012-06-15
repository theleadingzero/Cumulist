// our representation of a cursor
// declared 'public' so pointers can call its methods
public class CustomCursor
{
  float x, y;
  color fillColor;
  Pointer pointer;
  
  CustomCursor( Pointer p )
  { // pointer should tell this cursor when events occur
    p.addEventListener(this);
    x = p.x();
    y = p.y();
    fillColor = color( random(255), 100, 200 );
    pointer = p;
  }

  void draw()
  {
    fill(fillColor, 80);
    ellipse( x, y, 40, 40 );
  }

  // a pointer event handler
  void pointerMoved( Pointer p )
  {
    x = p.x();
    y = p.y();
  }
}
