class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  def index
    @chapter = Chapter.all.map{ |chapter| {course: chapter.course.name,
                             chapter: chapter.name,
                             unit: chapter.units.map{ |unit| unit.name }
                             }}
    render json: @chapter
  end

  def show
    @chapter = @course.chapters.map{ |chapter| { chapter: chapter,unit: chapter.units }}
    render json: @chapter
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      params[:chapter].each do |chapter_params|
        @chapter = @course.chapters.new(chapter_params.permit(:name))
        if @chapter.save
          chapter_params[:unit].each do |unit_params|
            @unit = @chapter.units.new(unit_params.permit(:name, :content, :description))
          end
        else
          render json: @unit.errors.full_messages
        end
        if @chapter.save
        else
          render json: @chapter.errors.full_messages, status: :unprocessable_entity
        end
      end
    else
      render json: @course.errors.full_messages, status: :unprocessable_entity
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
