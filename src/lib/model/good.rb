require_relative '../support/extensions.rb'

module Bariga
  # mix-in that describes expected attribuges for a Sellable entity
  module Sellable
    def price; end

    def availability; end
  end

  # mix-in with defined method for images
  module Viewable
    def images
      []
    end
  end

  # Basic entity that describes a product fetched from this or that marketplace
  class Good
    attr_reader :raw
    include Sellable
    include Viewable

    def initialize(props)
      @raw = props
      @object = @raw.to_obj
    end

    def single_price?
      price !~ price_separator
    end

    def price_range
      split_price = price.split(price_separator)
      @price_range = split_price.first..split_price.last
    end

    def price_min
      price_range.min
    end

    def price_max
      price_range.max
    end

    def to_s
      JSON.generate(@raw)
    end

    private

    def price_separator
      /\s*-\s*/
    end
  end
end
