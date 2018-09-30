module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound do |event|
      json_response({ message: event.message }, :not_found)
    end
  end

  private

  def four_twenty_two(event)
    json_response({ message: event.message }, :unprocessable_entity)
  end
end