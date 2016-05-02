class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :street
      t.string :number
      t.string :unit
      t.string :owned_by
      t.references :user, index: true
      t.references :neighborhood, index: true
      t.references :agent, index: true

      t.timestamps
    end
  end
end
