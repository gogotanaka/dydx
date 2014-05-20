module Dydx
  module Helper
    OP_SYM_STR = {
      addition:       :+,
      subtraction:    :-,
      multiplication: :*,
      exponentiation: :^
    }

    def is_0?
      self == 0 || (is_a?(Num) && n == 0)
    end

    def is_1?
      self == 1 || (is_a?(Num) && n == 1)
    end

    def is_minus1?
      self == -1 || (is_a?(Num) && n == -1)
    end

    def is_num?
      (is_a?(Num) || is_a?(Fixnum)) || (is_a?(Inverse) && x.is_num?)
    end

    def super_ope(operator)
      case operator
      when :+ then :*
      when :- then :/
      when :* then :^
      when :/ then :|
      end
    end

    def sub_ope(operator)
      case operator
      when :* then :+
      when :/ then :-
      when :^ then :*
      when :| then :/
      end
    end

    def inverse_ope(operator)
      case operator
      when :+ then :-
      when :- then :+
      when :* then :/
      when :/ then :*
      when :^ then :|
      when :| then :^
      end
    end

    def distributive?(ope1, ope2)
      [super_ope(ope1), inverse_ope(super_ope(ope1))].include?(ope2)
    end

    def combinable?(x, operator)
      case operator
      when :+
        like_term?(x)
      when :*
        self == x ||
        (is_num? && x.is_num?) ||
        inverse?(x, :*)
      when :^
        (is_num? && x.is_num?) || is_0? || is_1?
      end
    end

    def like_term?(x)
      self == x ||
      (is_num? && x.is_num?) ||
      (multiplication? && (f == x || g == x)) ||
      (x.multiplication? && (x.f == self || x.g == self)) ||
      inverse?(x, :+)
    end

    def is_multiple_of(x)
      if is_0?
        e0
      elsif self == x
        e1
      # elsif is_num? && x.is_num? && (self % x == 0)
      #   _(n / x.n)
      elsif multiplication? && (f == x || g == x)
        f == x ? g : f
      else
        false
      end
    end

    OP_SYM_STR.each do |operator_name, operator|
      define_method("#{operator_name}?") do
        (@operator == operator) && is_a?(Formula)
        # is_a?(Inverse) && self.operator == operator
      end
    end

    def to_str(sym)
      OP_SYM_STR.key(sym)
    end

    def str_to_sym(str)
      OP_SYM_STR[str]
    end

    def commutative?(operator)
      [:+, :*].include?(operator)
    end

    def inverse?(x, operator)
      if is_a?(Algebra::Inverse)
        self.operator == operator && self.x == x
      elsif x.is_a?(Algebra::Inverse)
        self == x.x
      else
        false
      end
    end

    def subtrahend?
       is_a?(Inverse) && operator == :+
    end

    def divisor?
       is_a?(Inverse) && operator == :*
    end
  end
end
