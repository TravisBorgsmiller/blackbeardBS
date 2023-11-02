class AddServiceToApps < ActiveRecord::Migration[7.0]
  def change
    add_column :apps, :service, :string
  end
end
