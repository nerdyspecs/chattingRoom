class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :host, null: false, default: false
      t.timestamps
    end
  end
end
