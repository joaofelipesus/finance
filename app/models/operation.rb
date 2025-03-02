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

  belongs_to :account

  validates :value, :kind, :date, :payment_method, presence: true

  enum :kind, KIND_OPTIONS
  enum :payment_method, PAYMENT_METHOD_OPETIONS
end
