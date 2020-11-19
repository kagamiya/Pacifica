class NullFalseToMusics < ActiveRecord::Migration[6.0]
  def change
    change_column_null :musics, :name, false
    change_column_null :musics, :artist, false
    change_column_null :musics, :artwork, false
    change_column_null :musics, :collection_id, false
  end
end
