module Validators
  module Schemas
    class Base
      def initialize(params)
        @params = params
      end

      def self.call(params)
        new(params).call
      end

      def call
        build_schema.call(params)
      end

      protected

      attr_reader :params, :schema

      def build_schema
        raise NotImplementedError
      end
    end
  end
end
