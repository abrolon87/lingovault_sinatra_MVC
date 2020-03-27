class CreateLanguagesTable < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :level
      t.string :exp
      t.integer :user_id 
    end
  end
end
