class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :type
      t.date :date
      t.time :time
      t.string :status
      t.string :confirmation
      t.string :contact
      t.references :property, index: true

      t.timestamps
    end
  end
end
