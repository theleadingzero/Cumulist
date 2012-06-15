/*
 * JSON 4 Processing
 * Basic example 5: Parsing the HTTP header from www.processing.org
 *
 * This example creates a JSONObject from the HTTP response when
 * contacting a website (www.processing.org).
 */
import org.json.*;
import java.net.URL;
import java.net.URLConnection;

URL url;
URLConnection conn;

void setup() {
  // Unfortunately there's a problem in the Processing Client implementation
  // that forces us to use straight Java.
  try {
    url = new URL("http://www.processing.org");
    conn = url.openConnection();
  }
  catch( Exception e) {
  }

  // We will manually add the entire HTTP reponse to this StringBuffer
  // and create the JSONObject using it.
  StringBuffer sb = new StringBuffer();
  
  // Construct the String object using the URLConnection.
  for (int i = 0;; i++) {
    String name = conn.getHeaderFieldKey(i);
    String value = conn.getHeaderField(i);
    if (name == null && value == null) {
      break;
    }
    if (name == null) {
      // Add the value, if there is no key-value pair.
      sb.append(value).append("\n");
    } 
    else {
      // Add the key-value pair.
      sb.append(name).append(":").append(value).append("\n");
    }
  }
  
  // Create the JSON HTTP instance
  HTTP http = new HTTP();
  
  // Create the JSONObject using the HTTP instance
  JSONObject obj = http.toJSONObject(sb.toString());
  
  // Print the JSONObject
  System.out.println(obj);
}
void draw() {
}

