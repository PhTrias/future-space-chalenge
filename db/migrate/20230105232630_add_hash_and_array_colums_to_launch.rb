class AddHashAndArrayColumsToLaunch < ActiveRecord::Migration[7.0]
  def change
    add_column :launches, :status, :text, hash: true, default: '{}'
    add_column :launches, :launch_service_provider, :text, hash: true, default: '{}'
    add_column :launches, :rocket, :text, hash: true, default: '{}'
    add_column :launches, :pad, :text, hash: true, default: '{}'
    add_column :launches, :program, :text, hash: true, default: '[]'
  end
end
