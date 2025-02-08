# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:health)
  end

  test "validate name presence" do
    @category.name = nil

    assert_not @category.valid?
    assert_equal @category.errors[:name], [ "can't be blank" ]
  end

  test "validate name uniqueness" do
    stocks = categories(:stocks)
    @category.name = stocks.name

    assert_not @category.valid?
    assert_equal @category.errors[:name], [ "has already been taken" ]
  end
end
