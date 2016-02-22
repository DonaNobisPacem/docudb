class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :control
      t.integer :office
      t.datetime :date
      t.string :received_by
      t.string :subject

      t.timestamps null: false
    end
  end
end
