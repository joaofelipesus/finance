# frozen_string_literal: true

class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :set_accounts, only: %i[new edit]

  # GET /operations or /operations.json
  def index
    @operations = Operation.all
  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.create_and_update_account(operation_params)

    if @operation.valid?
      redirect_to @operation, notice: "Operation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    if @operation.update(operation_params)
      redirect_to @operation, notice: "Operation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy!

    redirect_to operations_path, status: :see_other, notice: "Operation was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params.expect(:id))
  end

  def set_accounts
    @accounts = Account.order(name: :asc)
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.expect(operation: [ :kind, :value, :description, :account_id, :date, :payment_method ])
  end
end
