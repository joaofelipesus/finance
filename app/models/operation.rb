# frozen_string_literal: true

class Operation < ApplicationRecord
  KIND_OPTIONS = {
    earning: "earning",
    investment: "investment",
    spend: "spend"
  }.freeze

  KIND_COLORS = {
    "spend" => "#FF0000",    # Red
    "earning" => "#00FF00",  # Green
    "investment" => "#0000FF" # Blue
  }

  belongs_to :account

  validates :value, :kind, :date, presence: true

  enum :kind, KIND_OPTIONS
end
