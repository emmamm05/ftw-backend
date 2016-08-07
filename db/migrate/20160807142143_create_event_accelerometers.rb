class CreateEventAccelerometers < ActiveRecord::Migration
  def change
    create_table :event_accelerometers do |t|
      t.string :state
      t.references :wristband, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
