class SongCloud 
{
  PImage cloud;

  String username;
  PImage userImage;
  String song;
  String artist;
  String songURL;
  float xPos, yPos;
  color tintColor;
  int playlistLoc;
  
  SongCloud(float x, float y) {
    xPos = x;
    yPos = y;
    
    playlistLoc = -1;
    
    cloud = loadImage("cloud.png");
    userImage = loadImage("user.png");
    tintColor = color(255);

    song = "a song";
    artist = "singer songwriter";
  }

  void updatePosition(float x, float y) {
    xPos = x;
    yPos = y;
  }
  
  void updatePlaylistLoc(int loc) {
   playlistLoc = loc;
  }
  
  void updateUserImage(PImage p) {
   userImage = p; 
  }
  
  void updateUserColor(color c) {
   tintColor = c; 
  }

  boolean isColliding(float x, float y) {
    if (x >= xPos-80 && 
      x <= xPos + 250 &&
      y <= yPos +100 &&
      y >= yPos-30) 
      {
      return true;
      }

    return false;
  }

  void display() {
    tint(tintColor);
    image(cloud, xPos-80, yPos-40);
    tint(255);
    fill(100);
    image(userImage, xPos-43, yPos-14, 40, 40);
    fill(0);
    text(song, xPos, yPos);
    text(artist, xPos, yPos+25);
  }
}

