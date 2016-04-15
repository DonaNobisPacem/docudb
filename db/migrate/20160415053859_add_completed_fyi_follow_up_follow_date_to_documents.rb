class AddCompletedFyiFollowUpFollowDateToDocuments < ActiveRecord::Migration
  def change
  	add_column :documents, :folder, :string
    add_column :documents, :completed, :boolean
    add_column :documents, :fyi, :boolean
    add_column :documents, :follow_up, :boolean
    add_column :documents, :follow_date, :datetime
  end
end
