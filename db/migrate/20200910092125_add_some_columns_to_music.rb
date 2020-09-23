class AddSomeColumnsToMusic < ActiveRecord::Migration[6.0]
  def change
    add_column :musics, :artist, :string
    add_column :musics, :artwork, :string
    add_column :musics, :collection_id, :string
  end
end
