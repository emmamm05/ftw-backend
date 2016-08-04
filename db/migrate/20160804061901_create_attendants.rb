class CreateAttendants < ActiveRecord::Migration
  def change
    create_table :attendants do |t|
      t.string :name
      t.string :lastname
      t.integer :age
      t.string :gender
      t.references :circle, index: true, foreign_key: true
      t.integer :wristband_id
      t.string :area

      t.timestamps null: false
    end
  end
end
