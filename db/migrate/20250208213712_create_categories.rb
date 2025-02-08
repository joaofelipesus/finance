class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.timestamps

      t.string :name, comment: "The category name, for example Investment, Health..."
    end
  end
end
