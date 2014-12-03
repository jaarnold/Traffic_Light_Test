class AddSeqToJunctions < ActiveRecord::Migration
  def change
    add_column :junctions, :seq, :array
  end
end
