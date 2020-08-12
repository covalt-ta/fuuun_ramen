# frozen_string_literal: true

module ProductDecorator
  def display_price
    "#{price.to_s(:delimited)}円"
  end
end
