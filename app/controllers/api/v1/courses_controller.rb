class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  def index
    @courses = Course.includes(chapters: :  :unit)
  end

  def show
    @chapter = @course.chapters.map{ |chapter| { chapter: chapter,unit: chapter.units }}
    render json: { course: @course,chapters: @chapter }, status: 200
  end

  def create
    debugger
    @course = Course.new(course_params)
    if @course.save
      params[:chapter].each do |chapter_params|
        @chapter = @course.chapters.create(chapter_params.permit(:name))
        chapter_params[:unit].each do |unit_params|
          @unit = @chapter.units.create(unit_params.permit(:name, :content, :description))
        end
      end
    else
      render json: { course_errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    render json: { course_errors: @course.errors.full_messages } if not @course.update(course_params)

    if params[:chapter][:id]
      @chapter = @course.chapters.find(params[:chapter][:id])
      render json: { chapter_errors: @chapter.errors.full_messages }if not @chapter.update(chapter_params)
    end
    
    if params[:unit][:id]
      @unit = Unit.find(params[:unit][:id])
      if @unit.chapter.course == @course
        render json: { unit_errors: @unit.errors.full_messages } if not @unit.update(unit_params)
      else
        render json: { errors: "此單元非本課程的單元" }
      end
    end
  end

  def destroy
    if @course.destroy
      render json: { state: "課程刪除成功" }, status: 200
    else
      render json: @course.errors.full_messages
    end
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :teacher, :description)
    end

    def chapter_params
      params.require(:chapter).permit(:name,:position,:id,unit_attributes:[ :name, :content, :description ])
    end

    def unit_params
      params.require(:unit).permit(:name, :content, :description, :position,:id)
    end
end

