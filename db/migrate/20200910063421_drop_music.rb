class DropMusic < ActiveRecord::Migration[6.0]
  def change
    drop_table :musics
  end
end
