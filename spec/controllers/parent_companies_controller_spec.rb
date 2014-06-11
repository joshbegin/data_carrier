require 'spec_helper'

describe ParentCompaniesController do

  before(:each) do
    @pc1, @pc2 = FactoryGirl.create(:parent_company), FactoryGirl.create(:parent_company)
  end

  describe "When logged in" do
    login_user

    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "loads all of the Parent Companies into @parent_companies" do
        get :index
        expect(assigns(:parent_companies)).to match_array([@pc1, @pc2])
      end
    end

    describe "GET #show" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, id: @pc1.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do
        get :show, id: @pc1.id
        expect(response).to render_template("show")
      end

      it "loads the desired Parent Company into @parent_company" do
        get :show, id: @pc1.id
        expect(assigns(:parent_company)).to match(@pc1)
      end
    end

    describe "GET #edit" do
      it "should redirect to #index" do
        get :edit, id: @pc1.id
        expect(response).to redirect_to(parent_companies_path)
      end
    end

    describe "PUT #update" do
    end

    describe "DELETE #destroy" do
      it "does not delete the parent company" do
        expect{ delete :destroy, id: @pc1 }.to change(ParentCompany,:count).by(0)
      end
    end

    describe "As Admin" do
      login_admin

      describe "GET #edit" do
        it "responds successfully with an HTTP 200 status code" do
          get :edit, id: @pc1.id
          expect(response).to be_success
          expect(response.status).to eq(200)
        end
      end

      describe "DELETE #destroy" do
        it "deletes the parent company" do
          expect{ delete :destroy, id: @pc1 }.to change(ParentCompany,:count).by(-1)
        end

        it "redirects to parent_companies#index" do
          delete :destroy, id: @pc1
          expect(response).to redirect_to parent_companies_url
        end
      end
    end

  end

  describe "When not logged in" do

    describe "GET #index" do
      it "should redirect to signin" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #show" do
      it "should redirect to signin" do
        get :show, id: @pc1.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "should redirect to signin" do
        get :edit, id: @pc1.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

end