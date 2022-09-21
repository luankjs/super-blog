require 'swagger_helper'

RSpec.describe 'comments', type: :request do

  let(:user) { create(:user) }
  let(:article) { create(:article) }

  path '/articles/{article_id}/comments' do
    parameter name: :article_id, in: :path, type: :string, description: 'article_id'

    get('list comments') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:article_id) { article.id }

        before do
          create_list(:comment, 3, article_id: article.id)
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
          expect(records.size).to eq(3)
        end
      end
    end

    post('create comment') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          author_name: { type: :string },
          author_email: { type: :string },
        },
        required: [ 'text', 'author_name', 'author_email' ]
      }

      response(201, 'successful') do
        let(:article_id) { article.id }
        let(:comment) { attributes_for(:comment, article_id: article_id) }

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
  end

  path '/articles/{article_id}/comments/{id}' do
    parameter name: :article_id, in: :path, type: :string, description: 'article_id'
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show comment') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:article_id) { article.id }
        let(:comment) { create(:comment, article_id: article_id) }
        let(:id) { comment.id }

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

    patch('update comment') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          author_name: { type: :string },
          author_email: { type: :string },
        },
        required: [ 'text', 'author_name', 'author_email' ]
      }

      before do
        sign_in user
      end

      response(200, 'successful') do
        let(:article_id) { article.id }
        let(:comment) { create(:comment, article_id: article_id) }
        let(:id) { comment.id }

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

    put('update comment') do
      tags 'Admin'
      consumes 'application/json'

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          author_name: { type: :string },
          author_email: { type: :string },
        },
        required: [ 'text', 'author_name', 'author_email' ]
      }

      before do
        sign_in user
      end

      response(200, 'successful') do
        let(:article_id) { article.id }
        let(:id) { create(:comment, article_id: article.id).id }
        let(:comment) { attributes_for(:comment, article_id: article.id) }

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

    delete('delete comment') do
      tags 'Admin'

      response(204, 'successful') do
        let(:article_id) { article.id }
        let(:comment) { create(:comment, article_id: article_id) }
        let(:id) { comment.id }

        before do
          sign_in user
        end

        run_test!
      end
    end
  end
end
