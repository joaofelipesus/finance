class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.timestamps

      t.string :name, comment: "Account name"
      t.decimal :amount, precision: 15, scale: 2, default: 0.0, comment: "Account balance"
    end
  end
end
