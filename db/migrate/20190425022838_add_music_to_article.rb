class AddMusicToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :music, :string
  end
end
