class CreateSlides < ActiveRecord::Migration
  def self.up
    create_table :slides do |t|
      t.string :name, :null => false
      t.integer :sort_order  #, :null => false
      t.timestamps
    end

    add_index :slides, :sort_order
  end

  def self.down
    drop_table :slides
  end
end
