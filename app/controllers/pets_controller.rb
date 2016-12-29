class PetsController < ApplicationController

    def index
        @pets = current_user.pets
    end

    def new
        @pet = current_user.pets.new
    end

    def create
        @pet = current_user.pets.new(pet_params)
        if @pet.save
            redirect_to pets_path, success: 'Votre animal a bien été créé'
        else
            render :new
        end
    end

    private
    def pet_params
        params.require(:pet).permit(:name, :gender, :birthday)
    end
end
