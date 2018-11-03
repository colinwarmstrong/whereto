class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.integer :rank
      t.string :name
      t.string :state
      t.string :growth
      t.integer :population
      t.string :latitude
      t.string :longitude
    end
  end
end
