class StudentsController < ApplicationController
  before_action :set_course
  before_action :set_student, only: %i[show update destroy]

  # GET /courses/:course_id/students
  def index
    json_response(@course.students)
  end

  # GET /courses/:course_id/students/:idea
  def show
    json_response(@student)
  end

  # POST /courses/:course_id/students
  def create
    @course.students.create!(student_params)
    json_response(@course, :created)
  end

  # PUT /courses/:course_id/students/:id
  def update
    @student.update(student_params)
    head :no_content
  end

  # DELETE /courses/:course_id/students/:id
  def destroy
    @student.destroy
    head :no_content
  end

  private

  def student_params
    params.permit(:name)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_student
    @student = @course.students.find_by!(id: params[:id]) if @course
  end
end
