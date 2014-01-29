require 'spec_helper'

describe Spree::ReviewsHelper do
  context 'star' do
    specify do
      expect(star('a_class')).to eq '<span class="a_class"> &#10030; </span>'
    end
  end

  context 'mk_stars' do
    specify do
      matches = mk_stars(2).scan(/unlit/)
      expect(matches.length).to eq 3
    end
  end

  context 'txt_stars' do
    specify do
      expect(txt_stars(2, true)).to eq '2 out of 5'
    end

    specify do
      expect(txt_stars(3, false)).to be_a String
      expect(txt_stars(3, false)).to eq('3')
    end
  end
end