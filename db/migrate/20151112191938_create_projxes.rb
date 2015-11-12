class CreateProjxes < ActiveRecord::Migration
  def change
    create_table :projxes do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
