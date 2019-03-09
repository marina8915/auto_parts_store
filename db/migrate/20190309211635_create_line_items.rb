class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|

      t.references :product, foreign_key: true
      t.belongs_to :cart, foreign_key: true
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
