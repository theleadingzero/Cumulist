// Cumulist - MHD BCN 2012
// Amélie Anglade and Becky Stewart

// TODO
// arrayList of songs
// song content
// multiple users
// user photos
// audio
// pagination actions


import fullscreen.*;
import com.oblong.gspeak.*;

FullScreen fs;

PImage bg;
PImage testPhoto;
PFont helvFont;

ArrayList <SongCloud> songs;

Substrate substrate;
ArrayList<CustomCursor> cursors;

Pointer photoPointer;

/****************************
 Setup
 *****************************/
void setup() {
  size(1440, 900);

  // connect to g-speak server
  substrate = new Substrate (this);
  cursors = new ArrayList<CustomCursor>();

  bg = loadImage("bg.png");

  noStroke();
  helvFont = loadFont("Helvetica-Light-36.vlw");
  textFont(helvFont, 26); 

  songs = new ArrayList<SongCloud>();
  newClouds();

  // Create the fullscreen object
  fs = new FullScreen(this); 

  // enter fullscreen mode
  //fs.enter();
}

/****************************
 Draw
 *****************************/
void draw()
{
  image(bg, 0, 0, 1440, 900);

  for (int i=0; i<10; i++) {
    fill(i*10+20, 50); 
    rect(width/2-100, i*height/10, 350, height/10);
  }

  // detect any moving clouds
  for ( CustomCursor c : cursors )
  {
    for ( SongCloud s : songs )
    {
      if (s.isColliding(c.x, c.y) && c.dragging)
      {
        //println(c.x + c.y);
        s.updateUserColor(c.fillColor);
        s.updateUsername(c.pointer.provenance());
        s.updatePosition(c.x, c.y);
        s.updateUserImage(c.photo);
        println(c.dragging);

        //s.updateUser(c.pointer.provenance);
      }
    }
  }

  // draw everything to screen
  for ( SongCloud s : songs ) 
  {
    s.display();
  }

  for ( CustomCursor c : cursors)
  {
    c.draw();
  }
}

/****************************
 Clouds
 *****************************/
void newClouds()
{
  for (SongCloud s : songs )
  {
    if ( s.playlistLoc == -1)
      songs.remove(s);
    println("removed " + s);
  }
  for ( int i=0; i<8; i++ ) {
    songs.add( new SongCloud(random(10, width/4), random(20, height-300) ) );
    songs.add( new SongCloud(random(2*width/3, width-90), random(20, height-30) ) );
  }
}


/****************************
 Pointer
 *****************************/
void pointerAppeared(Pointer p)
{
  // check to see if this user already exists
  boolean alreadyExists = false;
  for ( CustomCursor c : cursors )
  {
    if (c.pointer.provenance() == p.provenance())
      alreadyExists = true;
  }
  if (!alreadyExists)
  {
    cursors.add( new CustomCursor(p) );
    println("Add" + p.provenance());
  }
}

void pointerVanished(Pointer p)
{
  println("remove" + p.provenance());
  for (int i=0;i<cursors.size();i++)
  {
    if (p == cursors.get(i).pointer)
      cursors.get(i).y = -200;
  }
}

void pointerHardened( Pointer p )
{
  for ( CustomCursor c : cursors )
  {
    if (c.pointer.provenance() == p.provenance())
      c.dragging = true;
  }
}

void pointerSoftened( Pointer p )
{
  for ( CustomCursor c : cursors )
  {
    if (c.pointer.provenance() == p.provenance())
      c.dragging = false;
  }
}

void pointerSwipedRight(Pointer p)
{
  newClouds();
}

void pointerSwipedLeft(Pointer p)
{
  newClouds();
}

void pointerSwipedUp(Pointer p)
{
  substrate.requestImage(p);
  photoPointer = p;
}

void pointerSwipedDown(Pointer p)
{
}

/****************************
 User Photo Ingestion
 *****************************/
void imageIngested(PImage img)
{
  // can I find out the provenance of this photo?

  PGraphics maskImage;
  maskImage = createGraphics(img.width, img.height, JAVA2D);
  maskImage.beginDraw();
  maskImage.rect(img.width/2-200, img.height/2-200, 400, 400);
  maskImage.endDraw();

  testPhoto = img; // if the mask changes every frame, we need to use a copy of it, keeping the original intact
  testPhoto.mask(maskImage);

  for ( CustomCursor c : cursors )
  {
    if ( c.pointer.provenance() == photoPointer.provenance() ) {
      c.addPhoto(testPhoto);
    }
  }
  
  for ( SongCloud s : songs )
  {
    if ( s.username == photoPointer.provenance() ) {
      s.updateUserImage(testPhoto);
    }
  }
}

