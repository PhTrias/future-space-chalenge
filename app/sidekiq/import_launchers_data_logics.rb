module ImportLaunchersDataLogics
  module_function

  def set_instance_variables
    @url = 'https://ll.thespacedevs.com/2.0.0/launch/'
    @params = { limit: 100 }
    @service = Launchers::Service.new
  end

  def import_data
    service_response = @service.import_data(@url, @params)

    return { error: service_response['detail'] } if service_response['detail'].present?

    service_response['results'].each do |launcher_data|
      ImportLaunchersService.call(launcher_data.deep_stringify_keys!)
    end

    @url = service_response['next']

    { successful: true }
  end

  def page_limit(url)
    url.split('offset=').last.to_i
  end
end
