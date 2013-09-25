module Spree::ReviewsHelper

  def star(the_class)
    content_tag(:span, " &#10030; ".html_safe, :class => the_class)
  end

  def mk_stars(m)
    (1..5).collect {|n| n <= m ? star("lit") : star("unlit") }.join
  end

  def txt_stars(n=5, show_out_of = true)
    res = I18n.t('star', :count => n)
    res += " #{t('out_of_5')}" if show_out_of
    res
  end

end
