module Admin

    class SpeciesController < ApplicationController

        def index
            @species = Species.all
        end

        def create
        end

        def new
        end


    end
end
