require 'swagger_helper'

RSpec.describe 'categories', type: :request do

  let(:user) { create(:user) } 

  path '/categories' do
    get('list categories') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        before do
          create_list(:category, 10)
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

    post('create category') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
            name: { type: :string },
        },
        required: [ 'name' ]
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

        let(:category) { attributes_for(:category) }

        run_test!
      end
    end
  end

  path '/categories/{id}' do
    before(:each) do
      sign_in user
    end

    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show category') do
      tags 'Admin'
      produces 'application/json'

      response(200, 'successful') do
        let(:category) { create(:category) }
        let(:id) { category.id }

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

    patch('update category') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :category, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
          },
          required: [ 'name' ]
      }

      response(200, 'successful') do
        let(:category) { attributes_for(:category) }
        let(:id) { create(:category).id }

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

    put('update category') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :category, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
          },
          required: [ 'name' ]
      }

      response(200, 'successful') do
        let(:id) { create(:category).id }
        let(:category) { attributes_for(:category) }

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

    delete('delete category') do
      tags 'Admin'
      let(:category) { create(:category) }

      response(204, 'successful') do
        let(:id) { category.id }

        run_test!
      end
    end
  end
end
