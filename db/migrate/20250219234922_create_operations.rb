class CreateOperations < ActiveRecord::Migration[8.0]
  def change
    create_table :operations do |t|
      t.timestamps

      t.references :account, null: false, foreign_key: true, comment: "Related account"
      t.string :kind, comment: "Operation kind, an enum with values (spend, earning, investment)"
      t.decimal :value, precision: 15, scale: 2, comment: "Monetary value of the operation"
      t.text :description, comment: "Operation description"
      t.datetime :date, comment: "When the operation happend"
    end
  end
end
