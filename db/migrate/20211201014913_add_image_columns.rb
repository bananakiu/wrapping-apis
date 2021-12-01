class AddImageColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :url, :string, null: true
    add_column :images, :tags, :string, null: true
  end
end
