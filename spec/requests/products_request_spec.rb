require 'rails_helper'

RSpec.describe "Products", type: :request do

  def login(user)
    post user_session_path, params: {
      user: {
        email: user.email, password: user.password
      }
    }
    follow_redirect!
  end
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    let(:attachment) { FactoryBot.create(:attachment, product: product) }

    it "returns http success" do
      get "/products"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    let(:user) { FactoryBot.create(:user) }
    before do
      login(user)
    end
    let(:product) { FactoryBot.build(:product) }
    it "returns http success" do
      get "/products/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }
    let(:files) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','images', 'rails.png'), 'image/png') }
    before do
      login(user)
      post '/products', params: {product: { name: 'Product', description: 'awesome', files: files }}
    end
    it "returns http success" do
      get "/products/#{Product.first.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    context 'Create product' do
      let(:user) { FactoryBot.create(:user) }
      let(:files) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','images', 'rails.png'), 'image/png') }
      before do
        login(user)
        post '/products', params: {product: { name: 'Product', description: 'awesome', files: files, format: :html }}
      end
      it "redirects  to products page" do
        expect(response).to have_http_status(302)
      end

      it "return flash message" do
        expect(flash[:notice]).to eq("Product was successfully created.")
      end
    end

    context 'No Create product' do
      let(:user) { FactoryBot.create(:user) }
      let(:files) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','images', 'rails.png'), 'image/png') }
      before do
        login(user)
        post '/products', params: { product: { name: '', description: 'awesome', files: files, format: :html } }
      end
      it "returns new page" do
        expect(response).to have_http_status(:success)
      end
    end
  end


end
