RSpec.describe Spree::ProductsController, type: :controller do
  [:avg_rating, :reviews_count].each do |attrib|
    it "adds #{attrib} to the set of allowed attributes" do
      expect(controller.permitted_product_attributes).to include(attrib)
    end
  end
end
