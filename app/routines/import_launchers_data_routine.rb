class ImportLaunchersDataRoutine
  def self.import_data
    @params = { limit: 100, offset: 1 }
    @service = Launchers::Service.new
    # acessar o endpoint que traz os dados #100
    service = create_launchers

    if service[:page] <= '2000'
      @params[:offset] += 1

      import_data
    end
  end

  def self.create_launchers
    launchers_data = @service.import_data(@params)
    response = ImportLaunchersService.call(launchers_data)
  end
end
