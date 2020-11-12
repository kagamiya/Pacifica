require 'rails_helper'
include ApplicationHelper

RSpec.describe StaticPagesController, type: :controller do
  describe 'Home' do
    it 'should get' do
      get :home
      expect(response.status).to eq(200)
    end
  end

  describe 'Help' do
    it 'should get' do
      get :help
      expect(response.status).to eq(200)
    end
  end
end
