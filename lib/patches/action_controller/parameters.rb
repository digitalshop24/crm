module ActionController
  class Parameters
    def empty_values?
      to_h.values.join('').empty?
    end
  end
end
