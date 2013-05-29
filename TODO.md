# Infrastructure
- Move this to github.com/LucidWorks
- Move TODO to issue tracker

# Testing
- Add unit tests for overridden BL functionality (like facets_helper stuff)

# Build
- Create build file (Rake?  How about buildr!) to create warbled distro, and push to S3 for download via s3cmd.
- Set up Jenkins CI unit, smoke, etc testing

# LWS integration
- Dynamically show search results and document details from Solr response rather than BL fixed config
- data source awareness
  * serve file system crawled files (optional to turn off, warn big in readme/how-to)
  
# /catalog -> /search
- Clean up, trim down BL config in catalog_controller
- Move catalog_controller to lucid_controller or something like that..., map it to /search URLs
- Ideally clean up URLs so [] kinda gunk is converted to path elements or request params

# Prism integration
- Bring in Lucid Prism, add in some autosuggest or analysis view, etc, Timeline?  Exhibit?

# Cleanup
- Remove MARC (SolrMarc, etc) stuff

# Blacklight and other open source contributions
- Contribute back search history fix to projectblacklight
- Perhaps adjust Blacklight itself to use a separate "solr-marc" library/gem and only pull it in when asked to do so (gem install solr-marc, task to pull in JAR file, .properties files, etc)
- push Prism to github/LucidWorks, clean it up, add CI build, and so on
