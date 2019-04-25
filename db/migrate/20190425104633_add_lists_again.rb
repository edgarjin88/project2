class AddListsAgain < ActiveRecord::Migration[5.2]
  def change
    add_column :userlists, :player, :text, array: true, default:[]
  end
end


