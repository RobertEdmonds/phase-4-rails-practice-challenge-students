class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    
        def index 
            students = Student.all 
            render json: students 
        end
    
        def show 
            student = Student.find(params[:id])
            render json: student 
        end
    
        def create 
            student = Student.create!(student_params)
            render json: student, status: :created 
        end
    
        def update 
            student = Student.find(params[:id])
            student.update!(student_params)
            render json: student, status: :no_content
        end
        
        def destroy 
            student = Student.find(params[:id])
            student.destroy 
            head :no_content
        end
    
        private 
    
        def render_not_found
            render json: {error: 'Instructor not found'}, status: :not_found
        end
    
        def student_params
            params.permit(:name, :major, :instructor_id, :age)
        end
    
        def record_invalid (invalid)
            render json: {error: invalid.record.errors}, status: :unprocessable_entity
        end
end
