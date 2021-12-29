class AddTagToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :tag, :string
  end
end
