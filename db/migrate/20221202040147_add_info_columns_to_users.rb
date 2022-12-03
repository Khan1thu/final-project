class AddInfoColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :location, :string
    add_column :users, :education, :string
    add_column :users, :website, :string
    add_column :users, :birthday, :date
  end
end
