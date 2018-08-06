class AddCreatedByToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :created_by, :bigint
  end
end
