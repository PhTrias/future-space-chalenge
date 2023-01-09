class ImportLaunchersService < ApplicationService
  def initialize(launchers_data)
    @launchers_data = launchers_data
  end

  def call
    create_launchers
  end

  private

  def create_launchers
    Rails.logger('####### Creating Launchers')

    @launchers_data['results'].each do |data|
      launch = Launch.new(data)

      if launch.save
        launch.imported_t = DateTime.now.strftime("%d/%m/%Y - %H:%M:%S")
        launch.import_status = 'published'
      else
        Rails.logger("####### Erro when creating launcher. Id: #{data['id']}, Name: #{data['name']}")
      end
    end

    { successful: true, next_page: launchers_data['next'] }
  end
end
