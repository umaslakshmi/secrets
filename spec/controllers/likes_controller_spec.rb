require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = @user.secrets.create(content:"hello")
    session[:id] = nil
  end
  describe "when not logged in" do
    it "cannot like a secret" do
      post :create, secret_id: @secret
      expect(response).to redirect_to("/sessions/new")
    end

    it "cannot unlike a secret" do
      delete :destroy, secret_id: @secret
      expect(response).to redirect_to("/sessions/new")
    end
  end

  describe "when signed in as the wrong user" do
    it "cannot create a like for someone else" do
      @wrong_user = User.create(name:"wrong user", email:"wrong@user.com", password:"password", password_confirmation:"password")
      session[:id] = @wrong_user.id
      post :create, secret_id: @secret
      expect(@secret.users_liked).to include(@wrong_user)
      expect(@secret.users_liked).to_not include(@user)
    end
  end
end
