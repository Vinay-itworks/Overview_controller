class CreateGeocoders < ActiveRecord::Migration[7.2]
  def change
    create_table :geocoders do |t|
      t.timestamps
    end
  end
end
