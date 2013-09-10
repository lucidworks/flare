module FlareConfig

  class << self
    def solr_url

      # TODO: modify this to have the LucidWorks-specific environment variables brought in under some config/*.rb and config/environments file so it's an app/env-level setting too

      @solr_url ||= ENV['SOLR_URL'] ||
          ("#{ENV['LUCIDWORKSCOREADDRESS']}/solr" if ENV['LUCIDWORKSCOREADDRESS']) ||
          'http://localhost:8888/solr'

      @solr_url
    end

    def lws_api_url
      @lws_api_url ||= ENV['LWS_API_URL'] ||
          ("#{ENV['LUCIDWORKSCOREADDRESS']}/api" if ENV['LUCIDWORKSCOREADDRESS']) ||
          'http://localhost:8888/api'

      @lws_api_url
    end

    def lws_admin_url
      # http://localhost:8989/admin/collections/collection1/document?id=file%3A%2FUsers%2Ferikhatcher%2FLWS-2.5.3%2Fdata%2Fsolr%2Fcores%2Fcollection1_0%2Fdata%2Ftlog%2Ftlog.0000000000000000056

      @lws_admin_url ||= ENV['LWS_ADMIN_URL'] ||
          ("#{ENV['LUCIDWORKSUIADDRESS']}/admin" if ENV['LUCIDWORKSUIADDRESS']) ||
          'http://localhost:8989/admin'

      @lws_admin_url
    end
  end
end
