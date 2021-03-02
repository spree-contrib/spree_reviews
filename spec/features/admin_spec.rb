require 'spec_helper'

describe 'Review Admin', :js do
  stub_authorization!

  let!(:review) { create(:review) }

  context 'index' do
    before do
      visit spree.admin_reviews_path
    end

    it 'list reviews' do
      expect(page).to have_content(review.product.name)
    end

    it 'approve reviews' do
      expect(review.approved).to be(false)
      within("tr#review_#{review.id}") do
        find('.approve').click
      end
      expect(review.reload.approved).to be(true)
    end

    it 'edit reviews' do
      expect(page).to have_text review.product.name
      within("tr#review_#{review.id}") do
        click_icon :edit
      end

      expect(page).to have_content('Editing')
      expect(page).to have_content(review.title)
    end
  end
end
