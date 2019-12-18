require 'rails_helper'

RSpec.describe 'Students API' do
  let!(:course) { create(:course) }
  let!(:students) { create_list(:student, 20, course: course) }
  let(:course_id) { course.id }
  let(:id) { students.first.id }

  describe 'GET /courses/:course_id/students' do
    before { get "/courses/#{course_id}/students" }

    context 'when course exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all the students in the course' do
        expect(json.size).to eq 20
      end
    end

    context 'when course does not exist' do
      let(:course_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Course/
      end
    end
  end

  describe 'GET /courses/:course_id/students/:id' do
    before { get "/courses/#{course_id}/students/#{id}" }

    context 'when student exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the student' do
        expect(json['id']).to eq id
      end
    end

    context 'when student does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Student/
      end
    end
  end

  describe 'POST /courses/:course_id/students' do
    let(:valid_attributes) { { name: 'Foo Bar' } }

    context 'when request attributes are valid' do
      before { post "/courses/#{course_id}/students", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when an invalid request' do
      before { post "/courses/#{course_id}/students", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a failure message' do
        expect(response.body).to match /Validation failed: Name can't be blank/
      end
    end
  end

  describe 'PUT /courses/:course_id/students/:id' do
    let(:valid_attributes) { { name: 'W. A. Mozart' } }

    before { put "/courses/#{course_id}/students/#{id}", params: valid_attributes }

    context 'when student exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end

      it 'updates the student' do
        updated_student = Student.find(id)
        expect(updated_student.name).to match /W. A. Mozart/
      end
    end

    context 'when the student does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Student/
      end
    end
  end

  describe 'DELETE /courses/:course_id/students/:id' do
    before { delete "/courses/#{course_id}/students/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end
