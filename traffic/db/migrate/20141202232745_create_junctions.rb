class CreateJunctions < ActiveRecord::Migration
  def change
    create_table :junctions do |t|
      t.string :title
      t.integer :lights

      t.timestamps
    end
  end
end
