class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # To enable cross origin requests for all routes:
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = '*'
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS, PUT, DELETE"
  end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end


  # GET ---------------------------------------------------------------------------# Add your ro utes here
  get "/pets" do
    pets = Pet.all
    pet.to_json
  end

  get "/pets/:id" do
    pet = Pet.find(params[:id])
    pet.to_json(only: [:name, :breed, :image_url])
  end

  get "/users" do
    pet.all.to_json
  end

  get "user/:id" do
    pet = Pet.find(params[:id])
    pet.to_json(only: [:name, :breed, :image_url])
  end


  # POST ---------------------------------------------------------------------------
  post "/pets" do
    pet = Pet.create(pet_params)
    pet.to_json
  end



  # PATCH ---------------------------------------------------------------------------
  patch "/pets/:id" do
    pet = Pet.find_by(id: params[:id])
    pet.update()
    pet.to_json
  end



  # DELETE ---------------------------------------------------------------------------
  delete "/pets/:id" do
    pet = pet.find(params[:id])
    pet.destroy
    pet.to_json
  end


end
