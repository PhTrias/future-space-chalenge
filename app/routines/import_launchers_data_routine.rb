class ImportLaunchersDataRoutine
  include ImportLaunchersDataLogics

  def run
    set_instance_variables

    loop do
      response = import_data

      break if response[:error].present? || page_limit(@url) >= 2100
    end
  end
end
