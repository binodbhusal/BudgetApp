class CreateGroupsRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_records, id: false do |t|
      t.references :group, foreign_key: true
      t.references :record, foreign_key: true
      t.timestamps
    end
  end
end
