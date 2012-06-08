import twitter4j.Twitter
import twitter4j.TwitterFactory
import twitter4j.Status
import twitter4j.DirectMessage
import twitter4j.auth.AccessToken
import twitter4j.auth.RequestToken

def proccessArguments(args){
    def cli = new CliBuilder(usage: 'tuit.groovy [-d recipientScreenName]||[-p] message')

    cli.with {
        d args:1, argName:'recipient,...,rX', longOpt: 'direct-message', 'Send a direct message'
        p longOpt:'public', 'public message'
    }

    def options = cli.parse(args) 
    if(!options || (!options.d && !options.p)) {
        cli.usage()
        return
    }
    options
}



/*
 * Ver api para saber como conseguir el accessTokenFile
 * http://twitter4j.org/en/code-examples.html#directMessage
 */
def twitterConnectionDance(Map c){
    Twitter twitter = new TwitterFactory().getInstance();
    twitter.setOAuthConsumer(c.consumerKey, c.consumerSecret);
    AccessToken accessToken = null
    def tokenFile = new File(c.accessTokenFile)
    if (tokenFile.exists()) {
        def tokenFileParse = new XmlParser().parse(tokenFile)
        accessToken = new AccessToken(tokenFileParse.token.text(),tokenFileParse.tokenSecret.text());
        twitter.setOAuthAccessToken(accessToken)
    }

    twitter
}

try{
    Map configuration = [consumerKey:'Dfr3My8xwpg06V27gg0qhw',
            consumerSecret:'e8zxJ52NdtP9CpwDP4hmXHPxjJUhcoT3LsWFM9bDkY',
            accessTokenFile:'accessToken.xml'
        ]


    options = proccessArguments(args)
    assert options, 'revisar los argumentos'

    println options.d 
    println options.arguments().join(' ')


    //Twitter twitter = twitterConnectionShow(configuration)
    
    String message = "Y aqui vamos otra vez..."
    //Status status = twitter.updateStatus(message);
    DirectMessage directMessage = twitter.sendDirectMessage("hgmiguel", message);
    System.out.println("Successfully sent " + message);

} catch (Exception e) {
    e.printStackTrace();
}
