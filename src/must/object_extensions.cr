module Must
  module ObjectExtensions
    def must(klass : Class)
      must.be_a(klass)
    end

    def must
      ::Must::Rule.new(self)
    end
  end
end
