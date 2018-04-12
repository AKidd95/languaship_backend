require 'rails_helper'

RSpec.describe Api::V1::UserController, type: :request do
  let!(:user)  { create(:user) }
  let(:object) { JSON.parse(response.body)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'GET /api/v1/user' do
    describe 'oneUser' do
      it 'Should return one user' do
        language = Language.new(name: 'French', native: true, learn: false)
        location = Location.new(locale: 'Jamaica')
        create(:user)
        user.location = location
        user.languages << language
        user.save
        get "/api/v1/user/#{user.id}", headers: headers

        expected_response = eval(file_fixture('user.txt').read)
        expect(object).to eq expected_response
      end
    end

    describe 'multiple Users' do
      context 'create two users' do
        before do
           2.times do
            create(:user)
            binding.pry
            language = Language.new(name: 'Dutch', native: false, learn: true)
            location = Location.new(locale: 'London')
            user.location = location
            user.languages << language
            user.save
          end
        end

        it 'Should return all users' do
          get '/api/v1/user', headers: headers
          expected_response = eval(file_fixture('users.txt').read)
          expect(object).to eq expected_response
        end
      end
    end
  end
end
