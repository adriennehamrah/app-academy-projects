require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) do
    User.create(username: "user1", password: "123456")
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'renders to show template' do
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of username and password' do
        get :create, params: {user: {username: 'adrienne'}}
        expect(flash.now[:errors]).to be_present
        expect(response).to render_template('new')
      end

      it 'validates password length is at least 6 characters' do
        get :create, params: {user: {username: 'adrienne', password: '1236'}}
          expect(flash.now[:errors]).to be_present
          expect(response).to render_template('new')
        end
      end

    context 'with valid params' do
      it 'redirects user to user page on success' do
        get :create, params: {user: {username: 'adrienne', password: '123456'}}
          expect(response).to redirect_to(user_url(User.last))
      end
    end
  end
end
