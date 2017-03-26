class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
    t.boolean :public, default: true
    t.timestamps null: false
    end
  end
end
