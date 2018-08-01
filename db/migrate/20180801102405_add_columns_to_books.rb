class AddColumnsToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :isbn, :bigint
    add_column :books, :page_count, :integer
    add_column :books, :description, :text
  end
end
