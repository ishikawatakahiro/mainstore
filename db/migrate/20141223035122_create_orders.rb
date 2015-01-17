class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
      t.string :pay_type
      t.boolean :delivery,default: false 
      t.date    :apointmentdate 

      t.timestamps
    end
  end
end
