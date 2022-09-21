require 'swagger_helper'

RSpec.describe 'posts', type: :request do

  let(:user) { create(:user) } 

  path '/posts' do
    get('list posts') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        before do
          create_list(:post, 10)
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

    post('create post') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
            title: { type: :string },
            body: { type: :string },
            category_id: { type: :number },
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

        let(:post) { attributes_for(:post) }

        run_test!
      end
    end
  end

  path '/posts/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show post') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:post) { create(:post) }
        let(:id) { post.id }

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

    patch('update post') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :post, in: :body, schema: {
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
        let(:post) { attributes_for(:post) }
        let(:id) { create(:post).id }

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

    put('update post') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :post, in: :body, schema: {
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
        let(:id) { create(:post).id }
        let(:post) { attributes_for(:post) }

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

    delete('delete post') do
      tags 'Admin'
      let(:post) { create(:post) }

      before do
        sign_in user
      end

      response(204, 'successful') do
        let(:id) { post.id }

        run_test!
      end
    end
  end
end
