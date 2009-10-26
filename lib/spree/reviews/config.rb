module Spree::Reviews
  class Config < Spree::Config
    class << self
      def instance
        return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
        ReviewsConfiguration.find_or_create_by_name("Reviews configuration")
      end
    end
  end
end

