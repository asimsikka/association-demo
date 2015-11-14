class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :projx, index: true
      t.boolean :accepted, default: false

      t.timestamps null: false
    end
  end
end
