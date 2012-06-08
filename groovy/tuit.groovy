import twitter4j.Twitter
import twitter4j.TwitterFactory
import twitter4j.Status
import twitter4j.DirectMessage
import twitter4j.auth.AccessToken
import twitter4j.auth.RequestToken

def proccessArguments(args){
    def cli = new CliBuilder(usage: 'tuit.groovy -f credentials.xml [-d recipientScreenName] [-p] message')

    cli.with {
        d args:1, argName:'recipient,...,rX', longOpt: 'direct-message', 'Send a direct message'
        p longOpt:'public', 'public message'
        f args:1, argName:'file with twitter credentials', longOpt:'credentials', 'Archivo xml con el token de autenticacion'
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
    options = proccessArguments(args)
    assert options, 'revisar los argumentos'

    assert options.f, 'Se necesita archivo con el token de auttenticacion'
    Map configuration = [consumerKey:'Dfr3My8xwpg06V27gg0qhw',
            consumerSecret:'e8zxJ52NdtP9CpwDP4hmXHPxjJUhcoT3LsWFM9bDkY',
            accessTokenFile:options.f
        ]


    message = options.arguments().join(' ')

    Twitter twitter = twitterConnectionDance(configuration)
    assert twitter, 'No se pudo contactar a twitter'

    if (options.d) {
        options.d.split(',').each {
            println "send direct message to $it"
            DirectMessage directMessage = twitter.sendDirectMessage(it, message);
        }
    }
    if (options.p) {
        Status status = twitter.updateStatus(message);
    }

    println("Successfully sent " + message);
    return
} catch (java.lang.AssertionError ae) {
    println ae
} catch (Exception e) {
    e.printStackTrace();
}

System.exit(1)
