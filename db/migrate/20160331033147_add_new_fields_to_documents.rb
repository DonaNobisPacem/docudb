class AddNewFieldsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :location, :text
    add_column :documents, :remarks, :text
  end
end
