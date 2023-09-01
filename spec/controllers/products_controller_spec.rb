RSpec.describe Spree::ProductsController, type: :controller do
  reviews_fields = [:avg_rating, :reviews_count]
  reviews_fields.each do |attrib|
    it "adds #{attrib} to the set of allowed attributes" do
      expect(controller.permitted_product_attributes).to include(attrib)
    end

    it "adds #{attrib} to the set of available attributes from Spree API" do
      expect(Spree::PermittedAttributes.product_attributes).to include(attrib)
    end
  end
end
