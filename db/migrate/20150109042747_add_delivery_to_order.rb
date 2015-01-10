class AddDeliveryToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery, :bool
  end
end
