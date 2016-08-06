class AddBluetoothOtherWristband < ActiveRecord::Migration
  def change
    add_column :event_bluetooths, :friend_wristband_id, :string
  end
end
