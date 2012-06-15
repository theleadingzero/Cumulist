/*
 * JSON 4 Processing
 * Basic example 4: Reading data from the web (Yahoo weather)
 *
 * This example reads the Weather feed from the Yahoo API's. It's using
 * the WOEID for Malmo, you can change this by finding the ID you want
 * at http://developer.yahoo.com/weather/
 */

import org.json.*;

void setup() {
  // Accessing the weather service
  String BASE_URL = "http://weather.yahooapis.com/forecastjson?w=";
  String WOEID = "898091";

  // Get the JSON formatted response
  String response = loadStrings( BASE_URL + WOEID )[0];

  // Make sure we got a response.
  if ( response != null ) {
    // Initialize the JSONObject for the response
    JSONObject root = new JSONObject( response );

    // Get the "condition" JSONObject
    JSONObject condition = root.getJSONObject("condition");
    
    // Get the "temperature" value from the condition object
    int temperature = condition.getInt("temperature");
    
    // Print the temperature
    println( temperature );
  }
}

void draw() {
}
