class MakeStatusADefaultValue < ActiveRecord::Migration
  def change
  	remove_column :appointments, :status
  	add_column :appointments, :status, :string, :default => "agendada"
  end
end
