# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :operations, dependent: :destroy

  def update_amount(operation:)
    update!(amount: amount + operation.value) if operation.earning?
    # TODO: handle money transfer from accounts.
    update!(amount: amount - operation.value) if operation.investment?
    # TODO: handle credit card spends.
    update!(amount: amount - operation.value) if operation.spend? && !operation.credit_card?
  end
end
