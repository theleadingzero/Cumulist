import com.soundcloud.api.*;
import org.apache.http.params.HttpParams;
import org.json.JSONException;
//import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
//import com.francisli.processing.http.*;
//import org.json.JSONArray;
//import org.json.JSONException;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.protocol.HTTP;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;

SCUser user1;

void setup() {
  size(200, 200);
  background(204);
  ApiWrapper wrapper = new ApiWrapper("0cOGePlKyGmdyrOKGc7eKQ", "QBKQS2zqeLziRiu0MPM97BQWRwve0WfoFiCGnLQXXzM", null, null, Env.LIVE);
  try {
     Token token = wrapper.login("utstikkar", "pwd"); //add password
     //println("got token from server: " + token);
     user1 = new SCUser(155339, wrapper, token); //amelie
     user2 = new SCUser(150728, wrapper, token); //becky
     user1.next_fav_set();
     user1.next_fav_set();
     user2.next_fav_set();
  } catch (IOException e) {
     println("Unable to create Token");
  }
}

class SCUser {
  
  final int DEFAULT_FAV_LIST_SIZE = 5;
  int id;
  int last_fav_index;
  int fav_list_size;
  JSONArray favs;
  ApiWrapper wrapper;
  Token token;
  
  SCUser(int tempID, ApiWrapper w, Token t){
    //SCUser(tempID, tempPermalink, tempUsername, DEFAULT_FAV_LIST_SIZE);
    id = tempID;
    last_fav_index = 0;
    fav_list_size = DEFAULT_FAV_LIST_SIZE;
    wrapper = w;
    token = t;
    
    String r = "/users/"+id+"/favorites";
      Request resource = Request.to(r);
      try { 
        HttpResponse resp = wrapper.get(resource);
        if (resp.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
          //System.out.println("Getting an answer\n");
          String json = Http.getString(resp);
          try {
            favs = new JSONArray(json);
          } catch (JSONException e) {
            println("could not parse JSON document: "+e.getMessage()+" "+
                    (json.length() > 80 ? (json.substring(0, 79) + "..." ) : json));
          }
          
        } else {
          System.out.println("Invalid status received: " + resp.getStatusLine());
        }
      } catch (IOException e) {
        System.out.println("Unable to GET "+r);
      }
    
  }
  
  SCUser(int tempID, int tempFavListSize, ApiWrapper w, Token t){
    id = tempID;;
    last_fav_index = 0;
    fav_list_size = tempFavListSize;
    wrapper = w;
    token = t;
    
    String r = "/users/"+id+"/favorites";
      Request resource = Request.to(r);
      try { 
        HttpResponse resp = wrapper.get(resource);
        if (resp.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
          //System.out.println("Getting an answer\n");
          String json = Http.getString(resp);
          try {
            favs = new JSONArray(json);
          } catch (JSONException e) {
            println("could not parse JSON document: "+e.getMessage()+" "+
                    (json.length() > 80 ? (json.substring(0, 79) + "..." ) : json));
          }
          
        } else {
          System.out.println("Invalid status received: " + resp.getStatusLine());
        }
      } catch (IOException e) {
        System.out.println("Unable to GET "+r);
      }
  }
  
  Track[] next_fav_set(){
    Track[] new_tracks = new Track[fav_list_size];
    int fav_index = last_fav_index;
    for (int i = 0; i < fav_list_size; i++){
      try { 
        JSONObject jsobj = favs.getJSONObject(fav_index);
        int track_id = jsobj.getInt("id");
        JSONObject author = jsobj.getJSONObject("user");
        String author_name = author.getString("username");
        String title = jsobj.getString("title");
        String stream = "";
        try {
          stream = jsobj.getString("stream_url");
        } catch (JSONException e) {             
        } 
        new_tracks[i] = new Track(track_id, author_name, title, stream);
      } catch (JSONException e) {
      }
      fav_index += 1; 
    }
    println("\n");
    last_fav_index += fav_list_size;
    return new_tracks;
  }
  
}
  
class Track {
  
  int id;
  String artist;
  String title;
  String stream;
  
  Track(int track_id, String author_name, String ttitle, String tstream){
    id = track_id;
    artist = author_name;
    title = ttitle;
    stream = tstream;
  }
  
  
}
