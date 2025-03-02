class AddPaymentMethodToOperation < ActiveRecord::Migration[8.0]
  def change
    add_column :operations,
      :payment_method,
      :string,
      comment: "A enum backed by a string that defines the operation payment method."
  end
end
