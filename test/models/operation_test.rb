# frozen_string_literal: true

require "test_helper"

class OperationTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:main_account)
    @operation_params = {
      value: 100,
      account: @account,
      kind: :spend,
      description: "UFC night with friends",
      date: 2.days.ago,
      payment_method: :pix
    }
    @operation = Operation.new(@operation_params)
  end

  test "defines KIND_OPTIONS constant with the correct values" do
    assert_equal Operation::KIND_OPTIONS, {
      earning: "earning",
      investment: "investment",
      spend: "spend"
    }
  end

  test "validates value presence" do
    @operation.value = nil

    assert_equal @operation.valid?, false
    assert_equal @operation.errors[:value], [ "can't be blank" ]
  end

  test "validates kind presence" do
    @operation.kind = nil

    assert_equal @operation.valid?, false
    assert_equal @operation.errors[:kind], [ "can't be blank" ]
  end

  test "validates date presence" do
    @operation.date = nil

    assert_equal @operation.valid?, false
    assert_equal @operation.errors[:date], [ "can't be blank" ]
  end

  test "defines PAYMENT_METHOD_OPTIONS enum with the correct values" do
    assert_equal Operation::PAYMENT_METHOD_OPETIONS, {
      credit_card: "credit_card",
      debit: "debit",
      pix: "pix"
    }
  end

  test ".display_value returns a string with the correct css classes when its a spend?" do
    @operation.kind = :spend
    @operation.value = 100.0

    result = @operation.display_value

    assert_equal result, "<span class=\"text-red-500 font-bold\">100.0</span>"
  end

  test ".display_value returns a string with the correct css classes when its a earning?" do
    @operation.kind = :earning
    @operation.value = 100.0

    result = @operation.display_value

    assert_equal result, "<span class=\"text-green-500 font-bold\">100.0</span>"
  end

  test ".display_value returns a string with the correct css classes when its a investment?" do
    @operation.kind = :investment
    @operation.value = 100.0

    result = @operation.display_value

    assert_equal result, "<span class=\"text-blue-500 font-bold\">100.0</span>"
  end

  test "#create_and_update_account create a new operation and update account ammount (earning)" do
    initial_amount = @account.amount
    @operation_params[:kind] = :earning

    assert_difference("Operation.count", 1) do
      Operation.create_and_update_account(@operation_params)
    end

    @account.reload
    assert_equal @account.amount, initial_amount + @operation_params[:value]
  end

  test "#create_and_update_account create a new operation and update account ammount (investment)" do
    initial_amount = @account.amount
    @operation_params[:kind] = :investment

    assert_difference("Operation.count", 1) do
      Operation.create_and_update_account(@operation_params)
    end

    @account.reload
    assert_equal @account.amount, initial_amount - @operation_params[:value]
  end

  test "#create_and_update_account create a new operation and update account ammount (spend)" do
    initial_amount = @account.amount
    @operation_params[:kind] = :spend

    assert_difference("Operation.count", 1) do
      Operation.create_and_update_account(@operation_params)
    end

    @account.reload
    assert_equal @account.amount, initial_amount - @operation_params[:value]
  end
end
