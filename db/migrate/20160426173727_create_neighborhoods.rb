class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.string :zip_code
      t.string :delegacion

      t.timestamps
    end
  end
end
