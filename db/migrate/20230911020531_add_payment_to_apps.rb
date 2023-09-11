class AddPaymentToApps < ActiveRecord::Migration[7.0]
  def change
    add_column :apps, :payment, :string
  end
end
