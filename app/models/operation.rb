# frozen_string_literal: true

class Operation < ApplicationRecord
  KIND_OPTIONS = {
    earning: "earning",
    investment: "investment",
    spend: "spend"
  }.freeze

  KIND_COLORS = {
    "spend" => "#E74C3C",    # Red
    "earning" => "#2ECC71",  # Green
    "investment" => "#3498DB" # Blue
  }.freeze

  PAYMENT_METHOD_OPETIONS = {
    credit_card: "credit_card",
    debit: "debit",
    pix: "pix"
  }.freeze

  VALUE_COLORS = {
    "spend" => "red",
    "earning" => "green",
    "investment" => "blue"
  }.freeze

  belongs_to :account

  validates :value, :kind, :date, :payment_method, presence: true

  enum :kind, KIND_OPTIONS
  enum :payment_method, PAYMENT_METHOD_OPETIONS

  # TODO: add coverage
  # TODO: extract to a concern
  def self.create_and_update_account(operation_params)
    operation = new(operation_params)
    ActiveRecord::Base.transaction do
      operation.save!

      account = operation.account
      account.update_amount(operation:)

      operation
    rescue ActiveRecord::RecordInvalid
      operation
    end
  end

  def display_value
    "<span class=\"text-#{VALUE_COLORS[kind]}-500 font-bold\">#{value}</span>"
  end
end
