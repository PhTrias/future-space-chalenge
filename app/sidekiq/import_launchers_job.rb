class ImportLaunchersJob
  include Sidekiq::Job
  include ImportLaunchersDataLogics
  sidekiq_options queue: 'import', retry: false

  def perform
    set_instance_variables

    loop do
      response = import_data

      break if response[:error].present? || page_limit(@url) >= 2100
    end
  end
end
