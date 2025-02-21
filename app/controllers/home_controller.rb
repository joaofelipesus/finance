# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @operation = Operation.new
  end

  # TODO: add coverage
  def create_operation
    operation = Operation.new(operation_params)

    if operation.save
      render turbo_stream: [
        turbo_stream.replace(
          'operation-form',
          partial: 'home/components/operation_form',
          locals: { operation: Operation.new }
        ),
        turbo_stream.replace(
          'success-message',
          partial: 'home/components/success_message',
          locals: { message: "Operation created" }
        )
      ]
    else
      # TODO: handle errors
      render turbo_stream: turbo_stream.replace(
        'operation-form',
        partial: 'home/components/operation_form',
        locals: { operation: Operation.new }
      )
    end
  end

  private

  def operation_params
    params.expect(operation: [ :kind, :value, :description, :account_id, :date ])
  end
end
