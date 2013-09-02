module BaseHelper
  def current_server
    core_url ||= ENV['LWS_API_URL']
    core_url ||= "#{ENV['LWS_CORE_URL']}" if ENV['LWS_CORE_URL']
  
    @current_server ||= LucidWorks::Server.new("#{core_url || 'http://127.0.0.1:8888'}")
  end
end