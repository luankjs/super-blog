require 'swagger_helper'

RSpec.describe 'tags', type: :request do

  path '/tags' do

    get('list tags') do
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
      consumes 'application/json'

      parameter name: :body, in: :body, required: true

      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:body) do
          { tag: attributes_for(:tag) }
        end

        run_test!
      end
    end
  end

  path '/tags/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show tag') do
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
      consumes 'application/json'

      parameter name: :body, in: :body, required: true

      response(200, 'successful') do
        let(:tag) { create(:tag) }
        let(:id) { tag.id }
        let(:body) do
          { tag: attributes_for(:tag) }
        end

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
      consumes 'application/json'

      parameter name: :body, in: :body, required: true

      response(200, 'successful') do
        let(:tag) { create(:tag) }
        let(:id) { tag.id }
        let(:body) do
          { tag: attributes_for(:tag) }
        end

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
      let(:tag) { create(:tag) }

      response(204, 'successful') do
        let(:id) { tag.id }

        run_test!
      end
    end
  end
end
