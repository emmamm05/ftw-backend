class AddDistanceParamsToEventLocalizations < ActiveRecord::Migration
  def change
    add_column :event_localizations, :real_distance_a, :float
    add_column :event_localizations, :real_distance_b, :float
    add_column :event_localizations, :real_distance_c, :float
    add_column :event_localizations, :coord_x, :float
    add_column :event_localizations, :coord_y, :float
  end
end
