# Blacklight powered by LucidWorks Search

## LucidWorks Search
LucidWorks Search, powered by Apache Solr, provides a commercially supported and easily
manageable search engine environment.  Data sources include web and file crawling,
database indexing, and much more.  It is easy to get the supported data sources
configured and feeding content into the system.  

## Blacklight: What is it and why use it?

In its own words, from [Project Blacklight](http://projectblacklight.org/)...

> Blacklight is an open source Solr user interface discovery platform.
> You can use Blacklight to enable searching and browsing of your collections.
> Blacklight uses the [Apache Solr](http://lucene.apache.org/solr) search engine
> to search full text and/or metadata.  Blacklight has a highly
> configurable Ruby on Rails front-end. Blacklight was originally developed at
> the University of Virginia Library and is made public under an Apache 2.0 license.
    
LucidWorks Search provides a search UI meant for administrative purposes, but is not designed or
recommended for production use by end-users.  Search applications generally demand a middle tier,
an application logic layer, between Solr and the client presentation layer.  Blacklight provides Solr
search and presentation services, an attractive and sophisticated customizable user interface, and a
vibrant, supportive open source community.  Blacklight has been deployed in production environments
for years in many sites around the world.

This project delivers the necessary adjustments and customizations needed on a default Blacklight application
enhanced to leverage the value added capabilities of the LucidWorks Search platform.

# Quickstart

1. Install LucidWorks Search
2. Install LWS-Blacklight
3. Run LWS-Blacklight

Use this to add the LucidWorks website as a web data source to your starting collection:

    curl -H 'Content-type: application/json' -d '{"crawler":"lucid.aperture", "type":"web","url":"http://www.lucidworks.com/","crawl_depth":2, "name":"LucidWebsite"}' http://localhost:8888/api/collections/collection1/datasources

And use this to start the crawl process for your starting collection:

    curl -X PUT 'http://localhost:8888/api/collections/collection1/datasources/all/job'
    
## Running pre-built app

If you've got a pre-built lws_blacklight.war, you can run it using:

    java -jar lws_blacklight.war

The current app configuration is set to use http://localhost:8888/solr/collection1 as the LucidWorks Search Solr server endpoint.

When running the executable web application, it runs on port 8080, and is accessible at http://localhost:8080

NOTE: The first request to the application can be quite slow currently (we'll explore ways to speed that up), so be patient.  Successive requests to
the same application will be spiffy.

# For developers

    * git clone github/LucidWorks/lws_blacklight

    * lws_blacklight git:(master) ✗ java -version
    java version "1.7.0_13"
    Java(TM) SE Runtime Environment (build 1.7.0_13-b20)
    Java HotSpot(TM) 64-Bit Server VM (build 23.7-b01, mixed mode)
    * lws_blacklight git:(master) ✗ export PATH=$HOME/bin/jruby-1.7.4/bin:$PATH
    * lws_blacklight git:(master) ✗ jruby -v
    jruby 1.7.4 (1.9.3p392) 2013-05-16 2390d3b on Java HotSpot(TM) 64-Bit Server VM 1.7.0_13-b20 [darwin-x86_64]
    * lws_blacklight git:(master) ✗ jruby -S rails server  
    => Booting WEBrick
    => Rails 3.2.13 application starting in development on http://0.0.0.0:3000
    => Call with -d to detach
    => Ctrl-C to shutdown server
    [2013-05-31 14:26:44] INFO  WEBrick 1.3.1
    [2013-05-31 14:26:46] INFO  ruby 1.9.3 (2013-05-16) [java]
    [2013-05-31 14:26:46] INFO  WEBrick::HTTPServer#start: pid=744 port=3000  
    
## Environment variables

This app will use the following environment variables to access LWS core API, user API, and Solr itself, falling back to the defaults specified:
    
* LWS_USER_API_BASE:
  defaults to http://127.0.0.1:8989 (uses /api/users/#{username} from the base)

* LWS_CORE_URL: defaults to http://127.0.0.1:8888

* LWS_API_URL: defaults to #{LWS_CORE_URL}/api, this is the base URL used for all LWS core (non-user) api, such as getting a list of available collections

* LWS_SOLR_URL: defaults to #{LWS_CORE_URL}/solr (collections are accessed from this Solr base url, such as /collection1/lucid?q=*:*...)

For example, LWS developers may run the LWS (lwe-ui) admin UI application using the default Rails port of 3000, so lws_blacklight can be run like this:

    LWS_USER_API_BASE=http://127.0.0.1:3000 jruby -S rails s -p 8080

# References

* [LucidWorks Search](http://www.lucidworks.com/products/lucidworks-search)
* [Blacklight](http://projectblacklight.org)
