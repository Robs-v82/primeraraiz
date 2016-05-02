class CreateAdds < ActiveRecord::Migration
  def change
    create_table :adds do |t|
      t.string :website
      t.string :url
      t.references :property, index: true

      t.timestamps
    end
  end
end
