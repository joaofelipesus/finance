# frozen_string_literal: true

class HomeController < ApplicationController
  OPERATION_PAGE_SIZE = 10

  def index
    @operation = Operation.new
    @page = params[:page] || 1
    @operations = fetch_operations
  end

  # TODO: add coverage
  def create_operation
    operation = Operation.new(operation_params)

    if operation.save
      render turbo_stream: [
        update_operation_form,
        success_message,
        update_operations_table,
        update_chart
      ]
    else
      # TODO: handle errors
      render turbo_stream: turbo_stream.replace(
        "operation-form",
        partial: "home/components/operation_form",
        locals: { operation: operation }
      )
    end
  end

  private

  def operation_params
    params.expect(operation: [ :kind, :value, :description, :account_id, :date ])
  end

  # TODO: refactor
  def fetch_operations
    if params[:page].blank? || params[:page].to_i == 1
      page_offset = 0
    else
      page_offset = params[:page].to_i * OPERATION_PAGE_SIZE
    end

    Operation.includes(:account).order(created_at: :desc).limit(OPERATION_PAGE_SIZE).offset(page_offset)
  end

  def update_operation_form
    turbo_stream.replace(
      "operation-form",
      partial: "home/components/operation_form",
      locals: { operation: Operation.new }
    )
  end

  def success_message
    turbo_stream.replace(
      "success-message",
      partial: "home/components/success_message",
      locals: { message: "Operation created" }
    )
  end

  def update_operations_table
    turbo_stream.replace(
      "operations-table",
      partial: "home/components/operations_table",
      locals: { operations: fetch_operations, page: OPERATION_PAGE_SIZE }
    )
  end

  def update_chart
    turbo_stream.replace(
      "chart",
      partial: "home/components/chart"
    )
  end
end
