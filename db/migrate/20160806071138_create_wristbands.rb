class CreateWristbands < ActiveRecord::Migration
  def change
    create_table :wristbands do |t|
      t.string :wristband_uuid
      t.references :attendant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
