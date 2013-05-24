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

# References

* [LucidWorks Search](http://www.lucidworks.com/products/lucidworks-search)
* [Blacklight](http://projectblacklight.org)
