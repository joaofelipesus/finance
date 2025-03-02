# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:main_account)
  end

  test "validate name presence" do
    @account.name = nil

    assert_equal @account.valid?, false
    assert_equal @account.errors[:name], [ "can't be blank" ]
  end

  test "validate name uniqueness" do
    investment_account = accounts(:investment_account)
    @account.name = investment_account.name

    assert_equal @account.valid?, false
    assert_equal @account.errors[:name], [ "has already been taken" ]
  end

  test ".update_amount increase amount when operation kind is a earning" do
    operation = operations(:salary_payment)
    operation.update!(kind: :earning, value: 200, payment_method: :pix)
    initial_amount = @account.amount
    @account.update_amount(operation:)

    @account.reload

    assert_equal @account.amount, initial_amount + 200
  end

  test ".update_amount decrease amount when operation kind is a investment" do
    operation = operations(:salary_payment)
    operation.update!(kind: :investment, value: 500, payment_method: :pix)
    initial_amount = @account.amount
    @account.update_amount(operation:)

    @account.reload

    assert_equal @account.amount, initial_amount - 500
  end

  test ".update_amount decrease amount when operation kind is a spend and operation method is pix" do
    operation = operations(:salary_payment)
    operation.update!(kind: :spend, value: 500, payment_method: :pix)
    initial_amount = @account.amount
    @account.update_amount(operation:)

    @account.reload

    assert_equal @account.amount, initial_amount - 500
  end

  test ".update_amount decrease amount when operation kind is a spend and operation method is debit" do
    operation = operations(:salary_payment)
    operation.update!(kind: :spend, value: 500, payment_method: :debit)
    initial_amount = @account.amount
    @account.update_amount(operation:)

    @account.reload

    assert_equal @account.amount, initial_amount - 500
  end

  test ".update_amount don't update the amount when operation kind is a spend and operation method is credit_card" do
    operation = operations(:salary_payment)
    operation.update!(kind: :spend, value: 500, payment_method: :credit_card)
    initial_amount = @account.amount
    @account.update_amount(operation:)

    @account.reload

    assert_equal @account.amount, initial_amount
  end
end
