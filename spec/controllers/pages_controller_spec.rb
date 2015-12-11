require "rails_helper"
RSpec.describe PagesController, type: :controller do
  describe "GET #search" do
    let!(:room1) { FactoryGirl.create(:room, address: "A28, 216 Nguyễn Văn Hưởng (Hẻm 2), Thảo Điền, Hồ Chí Minh, Vietnam") }
    let!(:room2) { FactoryGirl.create(:room, address: "195 Nguyen Van Huong Street, Thao Dien Ward, District 2 (195 Nguyễn Văn Hưởng, Phường Thảo Điền, Quận 2), Vietnam") }
    it "get all records match the key words" do

      get :search, q: {search: "Nguyễn Văn Hưởng (Hẻm 2), Thảo Điền, Hồ Chí Minh, Vietnam"}
      expect(assigns(:arr_rooms).size).to eq 2
    end
  end
end