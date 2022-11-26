require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  
  it 'index' do
    get :index
    expect(response).to have_http_status(200)
  end

  it 'show' do
    course = FactoryBot.create(:course)
    get :show, params: { id: course.id }
    expect(response).to have_http_status(200)
  end

    describe 'create' do 
      it 'creates record' do
        expect {
          post :create,params: { course: { name: "COURSE課程", teacher: "mike", description: "This is course!!!" },
          chapter: [{ name: "第1章",
                      unit: [{
                        name: "first unit", description: "this is unit", content: "the first class unit"}]}]}
        }.to change(Course, :count).by(1)
      end
      context 'course name & teacher can not be blank' do
        before do
          post :create, params: { course: { name: "", teacher: "", description: "This is course!!!" },
          chapter: [{ name: "第1章",
                      unit: [{
                        name: "first unit",    description: "this is unit", content: "the first class unit"}]}]}                 
        end

        it 'returns a unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'course name blank errors_message' do
          expect(response.body).to eq("{\"course_errors\":[\"Name can't be blank\",\"Teacher can't be blank\"]}")
        end
      end

      context 'chapter name can not be blank' do

        before do
          post :create, params: { course: { name: "hello", teacher: "mike", description: "This is course!!!" },
          chapter: [{ name: "",
                      unit: [{
                        name: "first unit",    description: "this is unit", content: "the first class unit"}]}]}                 
        end

        it 'returns a unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'chapter name blank errors_message' do
          expect(response.body).to eq("{\"chapter_errors\":[\"Name can't be blank\"]}")
        end
      end

      context 'unit name & content  can not be blank' do

        before do
          post :create, params: { course: { name: "hello", teacher: "mike", description: "This is course!!!" },
          chapter: [{ name: "第1章",
                      unit: [{
                        name: "", description: "this is unit", content: ""}]}]}                 
        end

        it 'returns a unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'unit name blank errors_message' do
          expect(response.body).to eq("{\"unit_errors\":[\"Name can't be blank\",\"Content can't be blank\"]}")
        end
      end

    end
end