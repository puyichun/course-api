class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  def index
    @courses = Course.all
    render json: @courses
  end

  def show
    render json: @course
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      params[:chapter].each do |chapter_params|
        @chapter = @course.chapters.new(chapter_params.permit(:name))
        @chapter.save
        chapter_params[:unit].each do |unit_params|
          unit = unit_params.permit(:name, :content, :description)
          @chapter.units.new(unit)
        end
        @chapter.save
        debugger
      end
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :teacher, :description)
    end

    def chapter_params
      params.require(:chapter).map { |chapter| chapter.permit(:name,:unit) }
    end

    # def unit_params
    #   params.require(:unit).map{ |unit| unit.permit(:name, :description, :content,:chapter_name) }
    # end
end
