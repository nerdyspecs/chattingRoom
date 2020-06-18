class RemoveHostFromRooms < ActiveRecord::Migration[6.0]
  def change
  	remove_column :rooms, :host
  end
end
