class AddArchivalActionToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :archival, :boolean
    add_column :documents, :action_subject, :string
    add_column :documents, :action_done, :string
  end
end
