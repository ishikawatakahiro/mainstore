class CreateAdminmails < ActiveRecord::Migration
  def change
    create_table :adminmails do |t|
      t.string :admin_mail

      t.timestamps
    end
  end
end
