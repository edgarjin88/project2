class AddUserListToUserlistTable < ActiveRecord::Migration[5.2]
  def change
    add_column :userlists, :userlist, :text, array: true, default:[]

  end
end
