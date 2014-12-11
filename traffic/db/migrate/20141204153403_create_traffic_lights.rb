class CreateTrafficLights < ActiveRecord::Migration
  def change
    create_table :traffic_lights do |t|
      t.boolean :red
      t.boolean :orange
      t.boolean :green
      t.references :junction, index: true

      t.timestamps
    end
  end
end
