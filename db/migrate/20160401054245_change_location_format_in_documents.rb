class ChangeLocationFormatInDocuments < ActiveRecord::Migration
  def up
   change_column :documents, :location, :string
  end

  def down
   change_column :documents, :location, :text
  end
end
