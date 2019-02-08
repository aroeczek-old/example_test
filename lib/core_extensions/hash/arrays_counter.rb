module CoreExtensions
  module Hash
    module ArraysCounter
      def number_of_arrays(min_elements: 0)
        self.arrays_count = 0
        self.min_array_elements = min_elements

        visit_hash(self)

        arrays_count
      end

      private

      attr_accessor :arrays_count, :min_array_elements

      def visit_hash(hash)
        hash.each do |key, value|
          value.is_a?(::Hash) ? visit_hash(value) : (value.is_a?(::Array) ? visit_array(value) : nil)
        end
      end

      def visit_array(array)
        count_grater(array)

        array.each do |value|
          value.is_a?(::Array) ? visit_array(value) : ( value.is_a?(::Hash) ? visit_hash(value) : nil)
        end
      end

      def count_grater(array)
        send(:arrays_count=, arrays_count + 1) if array.size > send(:min_array_elements)
      end
    end
  end
end
