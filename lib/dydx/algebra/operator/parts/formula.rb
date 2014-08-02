module Dydx
  module Algebra
    module Operator
      module Parts
        module Formula
          %w(+ *).map(&:to_sym).each do |op|
            define_method(op) do |rtm|
              if operator == op
                if tms[0].combinable?(rtm, op)
                  _(
                    _(tms[0], op, rtm), op, tms[1]
                  )
                elsif tms[1].combinable?(rtm, op)
                  _(
                    _(tms[1], op, rtm), op, tms[0]
                  )
                else
                  super(rtm)
                end
              elsif formula?(op.sub) && openable?(op, rtm)
                _(
                  _(tms[0], op, rtm), op.sub, _(tms[1], op, rtm)
                )
              elsif formula?(op.super) && rtm.formula?(op.super)
                cmn_fct = (tms & rtm.tms).first
                return super(rtm) unless cmn_fct

                if op.super.commutative?
                  _(
                    cmn_fct, op.super, _(delete(cmn_fct), op, rtm.delete(cmn_fct))
                  )
                else
                  return super(rtm) if index(cmn_fct) != rtm.index(cmn_fct)

                  case index(cmn_fct)
                  when 0
                    _(
                      cmn_fct, op.super, _(delete(cmn_fct), op.sub, rtm.delete(cmn_fct))
                    )
                  when 1
                    _(
                      _(delete(cmn_fct), op, rtm.delete(cmn_fct)), op.super, cmn_fct
                    )
                  end
                end
              elsif formula?(op.super) && rtm.inverse?(op) && rtm.x.formula?(op.super)
                cmn_fct = (tms & rtm.x.tms).first
                return super(rtm) unless cmn_fct

                if op.super.commutative?
                  _(
                    cmn_fct, op.super, _(delete(cmn_fct), op.inv, rtm.x.delete(cmn_fct))
                  )
                else
                  return super(rtm) if index(cmn_fct) != rtm.x.index(cmn_fct)
                  case index(cmn_fct)
                  when 0
                    _(
                      cmn_fct, op.super, _(delete(cmn_fct), op.sub.inv, rtm.x.delete(cmn_fct))
                    )
                  when 1
                    _(
                      _(delete(cmn_fct), op.inv, rtm.x.delete(cmn_fct)), op.super, cmn_fct
                    )
                  end
                end
              else
                super(rtm)
              end
            end
          end

          %w(**).map(&:to_sym).each do |op|
            define_method(op) do |rtm|
              if formula?(op.sub) && openable?(op, rtm)
                _(
                  _(tms[0], op, rtm), op.sub, _(tms[1], op, rtm)
                )
              else
                super(rtm)
              end
            end
          end
        end
      end
    end
  end
end
