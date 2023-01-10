namespace :launchers do
  desc "Routine to import launchers data"
  task import_data: :environment do
    ImportLaunchersDataRoutine.import_data
  end
end
