class CreateItems < ActiveRecord::Migration
  def change
  	create_table :items do |t|
  		t.string :image_url, :description, :title, :price, :product_url

  		t.timestamps 
  	end
  end
end
