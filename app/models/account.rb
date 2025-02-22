# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :operations, dependent: :destroy
end
