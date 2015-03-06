class CreateSurvey < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title

      t.timestamps
    end
  end
end
