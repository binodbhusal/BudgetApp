class CreateGroupsRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_records do |t|
      t.references :group, foreign_key: true
      t.references :record, foreign_key: true
      t.timestamps
    end
    add_index :groups_records, [:group_id, :record_id]
  end
end
