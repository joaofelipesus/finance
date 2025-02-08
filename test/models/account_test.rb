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
end
