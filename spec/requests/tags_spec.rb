require 'swagger_helper'

RSpec.describe 'tags', type: :request do

  let(:user) { create(:user) } 

  path '/tags' do
    before(:each) do
      sign_in user
    end

    get('list tags') do
      tags 'Admin'
      produces 'application/json'

      response(200, 'successful') do
        before do
          create_list(:tag, 10)
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

    post('create tag') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :tag, in: :body, schema: {
        type: :object,
        properties: {
            name: { type: :string },
        },
        required: [ 'name' ]
      }

      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:tag) { attributes_for(:tag) }

        run_test!
      end
    end
  end

  path '/tags/{id}' do
    before(:each) do
      sign_in user
    end

    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show tag') do
      tags 'Admin'
      produces 'application/json'

      response(200, 'successful') do
        let(:tag) { create(:tag) }
        let(:id) { tag.id }

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

    patch('update tag') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :tag, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
          },
          required: [ 'name' ]
      }

      response(200, 'successful') do
        let(:tag) { attributes_for(:tag) }
        let(:id) { create(:tag).id }

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

    put('update tag') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :tag, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
          },
          required: [ 'name' ]
      }

      response(200, 'successful') do
        let(:id) { create(:tag).id }
        let(:tag) { attributes_for(:tag) }

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

    delete('delete tag') do
      tags 'Admin'
      let(:tag) { create(:tag) }

      response(204, 'successful') do
        let(:id) { tag.id }

        run_test!
      end
    end
  end
end
