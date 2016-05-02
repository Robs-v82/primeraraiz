class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :mobile_phone
      t.string :other_phone
      t.string :password_digest
      t.string :rating

      t.timestamps
    end
  end
end
