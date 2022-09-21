require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/articles/1/comments").to route_to("comments#index", article_id: "1")
    end

    it "routes to #show" do
      expect(get: "/articles/1/comments/1").to route_to("comments#show", id: "1", article_id: "1")
    end


    it "routes to #create" do
      expect(post: "/articles/1/comments").to route_to("comments#create", article_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/articles/1/comments/1").to route_to("comments#update", id: "1", article_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/articles/1/comments/1").to route_to("comments#update", id: "1", article_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/articles/1/comments/1").to route_to("comments#destroy", id: "1", article_id: "1")
    end
  end
end
