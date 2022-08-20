class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index 
        instructors = Instructor.all 
        render json: instructors 
    end

    def show 
        instructor = Instructor.find(params[:id])
        render json: instructor 
    end

    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created 
    end

    def update 
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :no_content
    end
    
    def destroy 
        instructor = Instructor.find(params[:id])
        instructor.destroy 
        head :no_content
    end

    private 

    def render_not_found
        render json: {error: 'Instructor not found'}, status: :not_found
    end

    def instructor_params
        params.permit(:name )
    end

    def record_invalid (invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end
end
