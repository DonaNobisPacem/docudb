class AddOutgoingToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :outgoing, :boolean
  end
end
