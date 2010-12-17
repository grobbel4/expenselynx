require 'spec_helper'

describe StoresController do
  include Devise::TestHelpers
  
  before do
    @sara = Factory(:sara)
    @store = Store.create(:name => 'Moose Jaw')
  end
  
  context "GET edit" do
    it "should require user to log in to see a store for editing" do
      get :edit, :id => @store.to_param
      response.should redirect_to(new_user_session_path)
    end
    
    it "should contain the specified store" do
      sign_in @sara
      get :edit, :id => @store.to_param
      assigns(:store).name.should == @store.name
    end
  end
  
  context "PUT update" do
    it "should not change the store name for a normal user" do
      sign_in @sara
      put :update, :id => @store.to_param, :store => Store.new(:name => 'Coffee Place')
      assigns(:store).name.should_not == "Coffee Place"
    end
    
    it "should allow the user to assign an expense category" do
      sign_in @sara
      put :update, :id => @store.id, :store => Store.new(:name => 'Abc'), :expense_categories => "airfare"
      assigns(:store).expense_categories.length.should == 1
      assigns(:store).expense_categories.first.name.should == "airfare"
    end
  end
end