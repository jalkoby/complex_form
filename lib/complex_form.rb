module ComplexForm
  autoload :PropertyFactory, 'complex_form/property_factory'

  class Base
    class << self
      def properties(*args)
        if args.last.is_a?(Hash)
          options = args.pop
        else
          options = {}
        end

        @schema ||= []
        args.each do |name|
          @schema << ComplexForm::PropertyFactory.build(name, options)

          define_method(name)         { schema[name].get }
          define_method("#{ name }=") { |value| schema[name].set(value) }
        end
      end

      alias :property :properties

      def schema
        @schema ||= []
      end
    end

    def initialize(data = {})
      data.each do |key, value|
        define_singleton_method(key, lambda { value })
      end
      @schema = {}
      self.class.schema.each do |(klass, name, options)|
        schema[name] = klass.new(name, options, self)
      end
    end

    private

    def schema
      @schema
    end
  end
end
