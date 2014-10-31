module Dydx
  class Function
    attr_accessor :algebra, :vars
    def initialize(*vars)
      @vars = vars
    end

    def <=(algebra)
      @algebra = algebra
      self
    end

    def evalue(nums)
      subst_hash = Hash[*[@vars, nums].transpose.flatten]
      @algebra.subst(subst_hash).to_f
    end

    def differentiate(sym = :x)
      @algebra.differentiate(sym)
    end
    alias_method :d, :differentiate

    def to_s
      algebra.to_s
    end

    def ==(function)
      to_s == function.to_s
    end
  end
end
