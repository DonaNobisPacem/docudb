class AddLetterDateToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :letter_date, :datetime
  end
end
