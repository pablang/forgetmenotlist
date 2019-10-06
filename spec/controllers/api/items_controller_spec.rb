require 'rails_helper'

RSpec.describe Api::ItemsController, type: :request do
  describe 'POST #create' do
    context 'when item is valid' do
      let(:item) { { text: 'test', checked: false } }
      let(:params) { { item: item, format: :json } }
      before do
        post api_items_path, params: params
      end

      it 'returns http response success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json with the item text attribute' do
        expect(JSON.parse(response.body)['text']).to eq(item[:text])
      end
    end

    context 'when params are missing' do
      let(:item) { {} }
      let(:params) { { item: item, format: :json } }
      before do
        post api_items_path, params: params
      end
      it 'returns http code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when item exists' do
      let(:item) { FactoryBot.create :item }
      before do
        delete api_item_path(item.id)
      end

      it "destory exisitng item and respond with with 'no_content'" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when item does not exist' do
      let(:item) { FactoryBot.create :item }
      before do
        item.destroy
        delete api_item_path(item.id)
      end

      it "destroy non existing item and respond with 'no_content'" do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'PUT #update' do
    context 'when all fields are valid' do
      let(:item) { FactoryBot.create :item }
      let(:params) { { item: { checked: true }, format: :json } }
      before do
        put api_item_path(item.id), params: params
      end

      it 'should respond with JSON of item' do
        expect(JSON.parse(response.body)['checked']).to eq(true)
      end

      it 'should respond with SUCCESS status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when fields are missing' do
      let(:item) { FactoryBot.create :item }
      let(:params) { { item: {}, format: :json } }
      before do
        put api_item_path(item.id), params: params
      end

      it 'should respond with 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when can not find item' do
      let(:item) { FactoryBot.create :item }
      let(:params) { { item: { checked: true }, format: :json } }
      before do
        item.destroy
        put api_item_path(item.id), params: params
      end

      it 'should respond with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
