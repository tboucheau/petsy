class PagesController < ApplicationController
  def index
      @posts = Post.limit(10)
      @species = Species.all
      @pets = Pet.limit(4)
  end
end
