module Spree
   module ReviewsHelper

    def txt_stars(n, show_out_of = true)
      res = Spree.t(:star, count: n)
      res += " #{Spree.t('out_of_5')}" if show_out_of
      res
    end

  end
end
