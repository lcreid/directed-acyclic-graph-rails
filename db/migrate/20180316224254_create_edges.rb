class CreateEdges < ActiveRecord::Migration[5.2]
  def change
    create_table :edges do |t|
      t.references :parent, foreign_key: true, index: true
      t.references :child, foreign_key: true, index: true

      t.timestamps
    end
  end
end
