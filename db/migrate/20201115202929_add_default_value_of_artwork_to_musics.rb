class AddDefaultValueOfArtworkToMusics < ActiveRecord::Migration[6.0]
  def up
    change_column :musics, :artwork, :string, default: 'sample2.png'
  end

  def down
    change_column :musics, :artwork, :string
  end
end
