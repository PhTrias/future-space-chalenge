class CreateLaunches < ActiveRecord::Migration[7.0]
  def change
    create_table :launches do |t|
      t.string :url
      t.integer :launch_library_id
      t.string :slug
      t.string :name
      t.string :net
      t.string :window_end
      t.string :window_start
      t.boolean :inhold
      t.boolean :tbdtime
      t.boolean :tbddate
      t.integer :probability
      t.string :holdreason
      t.string :failreason
      t.string :hashtag
      t.boolean :webcast_live
      t.string :image
      t.string :infographic
      t.date :imported_t
      t.string :import_status

      t.timestamps
    end
  end
end
