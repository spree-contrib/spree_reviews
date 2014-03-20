require 'spec_helper'

# Regression for https://github.com/spree/spree_reviews/pull/103

feature "Reviews are shown properly" do
  given!(:product) { FactoryGirl.create(:product) }
  background do
    FactoryGirl.create_list :review, 3, product: product, approved: true
    Spree::Reviews::Config[:preview_size] = 2
  end

  scenario "displayed reviews are limited by the set preview size" do
    visit spree.product_path(product)

    expect(page.all(".review").count).to eql(2)
  end
end
