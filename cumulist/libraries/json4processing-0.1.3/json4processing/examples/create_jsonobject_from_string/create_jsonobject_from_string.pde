/*
 * JSON 4 Processing
 * Basic example 1: Creating a JSON Object from a json string
 */

import org.json.*;

void setup(){
  
  // 1. Get the json-string (we'll just create one...) 
  String jsonstring = "{\"myIntegerValue\":7}";
  
  // 2. Initialize the object
  JSONObject myJsonObject = new JSONObject(jsonstring);

  println( myJsonObject );
}

void draw(){
}