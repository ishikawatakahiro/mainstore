class AddApointmentdateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :apointmentdate, :date
  end
end
