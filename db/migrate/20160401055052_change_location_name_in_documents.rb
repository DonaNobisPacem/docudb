class ChangeLocationNameInDocuments < ActiveRecord::Migration
  def change
  	rename_column :documents, :location, :gdrive_link
  end
end
