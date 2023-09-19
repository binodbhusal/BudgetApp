class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.string :name
      t.decimal :amount
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
