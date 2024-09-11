class CreateJoinTableUsersSkills < ActiveRecord::Migration[7.2]
  def change
    create_join_table :skills, :users
  end
end
