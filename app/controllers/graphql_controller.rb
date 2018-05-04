class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    result = ActiveStorageSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    handle_error_in_development e
  end

  private

  def query
    params[:query]
  end

  def variables
    ensure_hash(params[:variables])
  end

  def operation_name
    params[:operationName]
  end

  def context
    context = {
      header: response.headers,
      current_user: current_user
    }
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")
    render json: { error: { message: e.message, backtrace: e.backtrace } }, status: 500
  end
end
