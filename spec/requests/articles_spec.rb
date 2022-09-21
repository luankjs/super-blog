require 'swagger_helper'

RSpec.describe 'articles', type: :request do

  let(:user) { create(:user) } 
  let(:category) { create(:category) }

  path '/articles' do
    get('list articles') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        before do
          create_list(:article, 10)
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          records = JSON.parse(response.body)
          expect(records.size).to eq(10)
        end
      end
    end

    post('create article') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          category_id: { type: :number },
          tag_ids: { 
            type: :array, 
            items: { type: :string } 
          }
        },
        required: [ 'title', 'body' ]
      }

      before do
        sign_in user
      end

      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:article) { attributes_for(:article, category_id: category.id) }

        run_test!
      end
    end
  end

  path '/articles/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show article') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:article) { create(:article) }
        let(:id) { article.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update article') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
          },
          required: [ 'name' ]
      }

      before do
        sign_in user
      end

      response(200, 'successful') do
        let(:article) { attributes_for(:article, category_id: category.id) }
        let(:id) { create(:article).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update article') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
          },
          required: [ 'name' ]
      }

      before do
        sign_in user
      end

      response(200, 'successful') do
        let(:id) { create(:article).id }
        let(:article) { attributes_for(:article, category_id: category.id) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete article') do
      tags 'Admin'
      let(:article) { create(:article) }

      before do
        sign_in user
      end

      response(204, 'successful') do
        let(:id) { article.id }

        run_test!
      end
    end
  end
end
