require 'rails_helper'

RSpec.describe ArticlesController, :type => :controller do

  before :each do
    #@request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user, :admin)
    sign_in @user
  end

  describe 'Get #new' do
  	it 'renders the new template for an admin' do
  	  get :new
      expect(response).to render_template('new')
    end

    xit 'raises an error if the user is not an admin' do
    	sign_out @user
    	unauthorised_user = FactoryGirl.create(:user)
    	sign_in unauthorised_user
      expect{get :new}.to raise_error(Pundit::NotAuthorizedError)
     end
  end

  describe 'Post #create' do

  	it 'should pass params to Article then save' do
  		post :create, :article => {:title => 'Hello1', :content => 'Hello2'}
  		assigns[:article].title.should == 'Hello1'
  		assigns[:article].content.should == 'Hello2'
  		flash[:notice].should_not be_nil
  		response.should redirect_to (articles_path)
  	end

  	it 'should render the new template on unsaved params' do
	    post :create, :article => {:title => 'Hello1', :content => ''}
	  	flash[:notice].should be_nil
	  	response.should render_template (:new)
  	end    

  end

  describe 'Get #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'load all of the articles into @articles' do
 	    article1 = Article.create!(:title => 'Hello 1', :content => 'Hello World 1')
 	    article2 = Article.create!(:title => 'Hello 2', :content => 'Hello World 2')
 	    get :index
 	    expect(assigns(:article)).to match_array([article1, article2])
    end
  end

  describe 'Get #show' do
    it 'renders the show template ' do
    	article = Article.create!(:id => 1, :title => 'Hello 1', :content => 'Hello World 1')
    	get :show, :id => article.id
    	expect(response).to render_template('show')
    end
  end

  describe 'Get #edit' do
  	it 'renders the edit template for an admin' do
  		article = Article.create!(:id => 1, :title => 'Hello 1', :content => 'Hello World 1')
  		get :edit, :id => article.id
  		expect(response).to render_template('edit')

  	end
  end

end