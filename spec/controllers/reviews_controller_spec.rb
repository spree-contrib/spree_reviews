require 'spec_helper'

describe Spree::ReviewsController do
  let(:token) { 'some_token' }
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before do
    controller.stub :spree_current_user => user
    controller.stub :spree_user_signed_in? => true
  end

  context '#index' do
    context 'for a product that does not exist' do
      it 'responds with a 404' do
        spree_get :index, product_id: 'not_real'
        response.status.should eq(404)
      end
    end

    context 'for a valid product permalink' do
      it 'should render the page' do
        spree_get :index, product_id: product.permalink
        response.status.should eq(200)
        response.should render_template(:index)
      end

      it 'should render the page' do
        reviews = [
          create(:review, product: product, approved: true, created_at: 4.days.ago),
          create(:review, product: product, approved: true, created_at: 2.days.ago)
        ]
        create(:review, product: product, approved: false, created_at: 1.days.ago)
        spree_get :index, product_id: product.permalink
        response.status.should eq(200)
        response.should render_template(:index)
        assigns(:approved_reviews).should eq([reviews[1], reviews[0]])
      end

    end
  end

  context '#new' do
    context 'for a product that does not exist' do
      it 'responds with a 404' do
        spree_get :new, product_id: 'not_real'
        response.status.should eq(404)
      end
    end

    context 'for a valid product permalink' do
      it 'should render the page' do
        spree_get :new, product_id: product.permalink
        response.status.should eq(200)
        response.should render_template(:new)
      end
    end
  end

  context '#create' do
    context 'for a product that does not exist' do
      it 'responds with a 404' do
        spree_post :create, { product_id: 'not_real' }, { access_token: token }
        response.status.should eq(404)
      end
    end

    context 'for a valid product permalink' do
      context 'with valid params' do
        it 'creates a new review' do
          rating = 4
          title = Faker::Lorem.words(4).join(' ')
          review_body = Faker::Lorem.paragraphs(3).join("\n")
          name = Faker::Internet.email
          expect {
            spree_post :create, { product_id: product.permalink,
                                  review: { review: review_body,
                                            rating: rating,
                                            name: name,
                                            title: title }},
                                { access_token: token }
            response.should redirect_to(spree.product_path(product))
          }.to change(Spree::Review, :count).by(1)
          review = Spree::Review.last
          review.title.should eq(title)
          review.review.should eq(review_body)
          review.rating.should eq(rating)

        end
      end

      context 'with params that are not valid' do
        it 'does not create a review and renders the new template' do
          rating = 'not_a_number'
          title = Faker::Lorem.words(4).join(' ')
          review_body = Faker::Lorem.paragraphs(3).join("\n")
          name = Faker::Internet.email
          expect {
            spree_post :create, { product_id: product.permalink,
                                  review: { review: review_body,
                                            rating: rating,
                                            name: name,
                                            title: title }},
                                { access_token: token }
            response.should render_template(:new)
          }.not_to change(Spree::Review, :count)

        end
      end
    end
  end
end