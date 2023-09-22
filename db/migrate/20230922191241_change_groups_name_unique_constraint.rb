class ChangeGroupsNameUniqueConstraint < ActiveRecord::Migration[6.0]
  def change
    # Remove the existing unique constraint on the name column
    remove_index :groups, name: 'index_groups_on_name'

    # Add a new unique constraint that combines user_id and name columns
    add_index :groups, [:user_id, :name], unique: true, name: 'index_groups_on_user_id_and_name'
  end
end
