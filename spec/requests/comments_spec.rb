require 'swagger_helper'

RSpec.describe 'comments', type: :request do

  let(:user) { create(:user) }
  let(:post) { create(:post) }

  path '/posts/{post_id}/comments' do
    parameter name: :post_id, in: :path, type: :string, description: 'post_id'

    get('list comments') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:post_id) { post.id }

        before do
          create_list(:comment, 3, post_id: post.id)
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
        let(:post_id) { post.id }
        let(:comment) { attributes_for(:comment, post_id: post_id) }

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

  path '/posts/{post_id}/comments/{id}' do
    parameter name: :post_id, in: :path, type: :string, description: 'post_id'
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show comment') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:post_id) { post.id }
        let(:comment) { create(:comment, post_id: post_id) }
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
        let(:post_id) { post.id }
        let(:comment) { create(:comment, post_id: post_id) }
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
        let(:post_id) { post.id }
        let(:id) { create(:comment, post_id: post.id).id }
        let(:comment) { attributes_for(:comment, post_id: post.id) }

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
        let(:post_id) { post.id }
        let(:comment) { create(:comment, post_id: post_id) }
        let(:id) { comment.id }

        before do
          sign_in user
        end

        run_test!
      end
    end
  end
end
