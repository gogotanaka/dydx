require 'dydx/helper'
require 'dydx/algebra'
require 'dydx/delta'
require 'dydx/function'
require 'dydx/integrand'

require 'dydx/api'

module Dydx
  include Algebra
  %w(f g h temp_cal_f).each do |functioner|
    define_method(functioner) do |*vars|
      function = eval("$#{functioner}")
      return eval("$#{functioner} = Function.new(*vars)") unless function

      unless function.vars.count == vars.count
        fail ArgumentError, "invalid number of values (#{vars.count} for #{function.vars.count})"
      end

      return function if function.vars == vars || !function.algebra

      function.evalue(vars)
    end
  end

  def S(function, delta)
    itgrl_var = delta.var
    unless function.is_a?(Function)
      eval "g(#{itgrl_var}) <= #{function}"
      function = g(x)
    end
    Integrand.new(function, itgrl_var)
  end

  def d
    Delta.new
  end

  def reset
    $f, $g, $h = nil, nil, nil
  end

  def _(*args)
    case args.count
    when 1
      num = args.first
      Num.new(num)
    when 3
      ltr, op, rtr = args
      ltr.send(op, rtr)
    end
  end

  def method_missing(method, *args, &block)
    method_name = method.to_s
    if method_name =~ /^d.$/
      Delta.new(method_name[1].to_sym, args.first)
    elsif method_name =~ /^[a-z]$/
      method_name.to_sym
    else
      super
    end
  end
end
