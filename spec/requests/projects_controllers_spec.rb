require 'rails_helper'

describe "ProjectsControllers" do
  describe "GET /projects_controller" do
    it "works! (now write some real specs)" do
      get projects_path
      expect(response).to have_http_status(302)
    end
  end
end
