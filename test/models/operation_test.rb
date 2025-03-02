# frozen_string_literal: true

require "test_helper"

class OperationTest < ActiveSupport::TestCase
  setup do
    @operation = Operation.new(
      value: 100,
      account: accounts(:main_account),
      kind: :spend,
      description: "UFC night with friends",
      date: 2.days.ago
    )
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
end
