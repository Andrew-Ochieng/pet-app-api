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
    pets = Pet.all.to_json(include: [:pets])
  end

  get "/pets/:id" do
    pet = Pet.find_by(id: params[:id])

    if(pet.nil?)
      status 404
      {error: "Pet not found"}.to_json
    else
      pet.to_json(include: [:pets])
    end
  end

  get "/users" do
    User.all.to_json(include: [:pets])
  end

  get "user/:id" do
    user = User.find_by(id: params[:id])

    if(user.nil?)
      status 404
      {error: "User not found"}.to_json
    else
      user.to_json(include: [:pets])
    end
  end


  # POST ---------------------------------------------------------------------------
  post "/pets" do
    pet = Pet.create(
      user_id: params[:user_id],
      name: params[:name],
      breed: params[:breed],
      image_url: [:image_url]
    )

    status 201
    pet.to_json(include: [:user])
  end



  # PATCH ---------------------------------------------------------------------------
  patch "/pets/:id" do
    pet = Pet.find_by(id: params[:id])

    if(pet.nil?)
      status 404
      {error: "Pet not found"}.to_json
    else
      pet.update(
        user_id: params[:user_id],
        name: params[:name],
        breed: params[:breed],
        image_url: [:image_url]       
      )
      pet.to_json
    end
  end

  # DELETE ---------------------------------------------------------------------------
  delete "/pets/:id" do
    pet = pet.find_by(params[:id])

    if(pet.nil?)
      status 404
      {error: "Pet not found"}.to_json
    else
      pet.destroy
      
      status 204
      {deleted: "Pet deleted successfully"}
    end
  end
end
