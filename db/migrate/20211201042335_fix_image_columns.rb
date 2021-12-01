class FixImageColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :url
    add_column :images, :upload_id, :string
  end
end
