require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user, :seller) }
  # let(:product) { FactoryBot.build(:product).attributes}
  before(:each) { sign_in(user) }

  describe 'GET #index' do
    it 'seller products page' do
      get 'index'
      should use_before_action(:load_seller_products)
      expect(response).to render_template(:index)
    end
  end

  describe '#new' do
    let(:product) { build(:product) }
    it 'renders new template' do
      get 'new'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    let(:product2) { create(:product) }
    it 'show product' do
      get 'show', params: { id: product2.slug }
      expect(response).to render_template('index/product')
    end
  end

  describe 'POST #create' do
    let(:category) { create(:category) }
    let(:brand) { create(:brand) }
    let(:product5) { build(:product).attributes }

    it 'create new product' do
      post 'create', params: { product: { **product5, category_id: category.id, brand_id: brand.id }   }
      expect(Product.last.name).to eq(product5[:name])
    end

    it 'redirect to new product' do
      expect(response).to redirect_to(new_product_path)
    end
  end

  describe 'PUT #update' do
    it 'update product' do
      product = create(:product)
      patch :update, params:
      {
        id: product.id,
        product: { **build(:product).attributes }
      }
      flash[:error].should nil?
      expect(response).to redirect_to(products_path)
    end

    it 'redirect to edit page' do
      product = create(:product)
      patch :update, params:
      {
        id: product.id,
        product: { **build(:product).attributes }
      }
      expect(response).to redirect_to(edit_product_path(product.id))
    end
  end

  describe '#edit' do
    it 'renders edit template' do
      get 'edit', params: { id: create(:product) }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroys product' do
      product = create(:product)
      expect do
        delete 'destroy', params: { id: product.id }
      end.to change(Product, :count).by(-1)
      flash[:error].should nil?
      expect(response).to redirect_to(products_path)
    end
  end
end
