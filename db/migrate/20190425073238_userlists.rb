class Userlists < ActiveRecord::Migration[5.2]
  def change
    create_table :userlists do |t|
      t.text :userlist
      t.integer :article_id


    end
  end
end
