class AddAttachmentAvatarToAppointments < ActiveRecord::Migration
  def self.up
    change_table :appointments do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :appointments, :avatar
  end
end
