module Dydx
  module API
    class << self
      def store_func(vars, formula, symbol)
        func_obj = Function.new(*vars)
        func_obj <=(formula)
        eval("$#{symbol.to_s} = func_obj")
      end

      def eval_func(nums, symbol)
        func = eval("$#{symbol.to_s}")
        func.evalue(nums)
      end

      def reset!
        $tmp, $temp_cal_f = nil, nil
      end
    end
  end
end
