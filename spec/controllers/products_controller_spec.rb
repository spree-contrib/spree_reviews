RSpec.describe Spree::ProductsController, type: :controller do
  reviews_fields = [:avg_rating, :reviews_count]
  reviews_fields.each do |attrib|
    it "adds #{attrib} to the set of allowed attributes" do
      expect(controller.permitted_product_attributes).to include(attrib)
    end
  end
  reviews_fields.each do |attrib|
    it "adds #{attrib} to the set of available attributes from Spree API" do
      expect(Spree::Api::ApiHelpers.product_attributes).to include(attrib)
    end
  end
end
