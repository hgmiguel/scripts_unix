import twitter4j.Twitter
import twitter4j.TwitterFactory
import twitter4j.Status
import twitter4j.auth.AccessToken
import twitter4j.auth.RequestToken
import java.io.BufferedReader
import com.thoughtworks.xstream.XStream


try{

   Twitter twitter = new TwitterFactory().getInstance();

   // set key and secret that you get from Twitter app registeration at:
   //     http://dev.twitter.com/pages/auth#register




   twitter.setOAuthConsumer("Dfr3My8xwpg06V27gg0qhw", "e8zxJ52NdtP9CpwDP4hmXHPxjJUhcoT3LsWFM9bDkY");

   // load access token if it exists
   AccessToken accessToken = null
   def tokenFile = new File("accessToken.xml")

   if (tokenFile.exists()) {
    def tokenFileParse = new XmlParser().parse("accessToken.xml")
    println "${tokenFileParse.token.text()}"
    println "${tokenFileParse.token} *** ${tokenFileParse.tokenSecret}"

      accessToken = new AccessToken(tokenFileParse.token.text(),tokenFileParse.tokenSecret.text());
      twitter.setOAuthAccessToken(accessToken)
   } 

   else {

     // get the URL to request access to Twitter acct
     RequestToken requestToken = twitter.getOAuthRequestToken();
     String authUrl = requestToken.getAuthorizationURL()
     System.out.println("Open the following URL and grant access to your account:");
     System.out.println(authUrl);

     // take the PIN and get access token
     System.out.print("Enter the PIN:");
     BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
     String pin = ""
     pin = br.readLine();
     accessToken = twitter.getOAuthAccessToken(requestToken, pin);

     // persist token
     def xstream = new XStream()
     xstream.classLoader = getClass().classLoader
     new File("accessToken.xml").withOutputStream { out -> xstream.toXML(accessToken, out) }
   }

   String message = "Y aqui vamos..."
   Status status = twitter.updateStatus(message);
   System.out.println("Successfully sent " + message);

} catch (Exception e) {
   e.printStackTrace();
}
