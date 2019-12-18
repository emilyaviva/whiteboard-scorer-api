class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  # GET /courses
  def index
    @courses = Course.all
    json_response(@courses)
  end

  # POST /courses
  def create
    @course = Course.create!(course_params)
    json_response(@course, :created)
  end

  # GET /course/:id
  def show
    json_response(@course)
  end

  # PUT /courses/:id
  def update
    @course.update(course_params)
    head :no_content
  end

  # DELETE /courses/:id
  def destroy
    @course.destroy
    head :no_content
  end

  private

  def course_params
    # whitelist params
    params.permit(:code, :language)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
