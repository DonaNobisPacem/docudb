class AddUrgentToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :urgent, :boolean
  end
end
