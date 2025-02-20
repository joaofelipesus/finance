# frozen_string_literal: true

class Operation < ApplicationRecord
  KIND_OPTIONS = {
    earning: "earning",
    investment: "investment",
    spend: "spend"
  }.freeze

  belongs_to :account

  validates :value, :kind, :date, presence: true

  enum :kind, KIND_OPTIONS
end
