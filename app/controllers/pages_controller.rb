class PagesController < ApplicationController

    skip_before_action :only_signed_in

    def index
        @posts = Rails.cache.fetch('posts_homepage') do
            Post.limit(10).all.to_a
        end
    end
end
