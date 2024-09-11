class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  # before_action :check_status
  # around_action :check_user
  # after_action :check_status

  def home
    @active_user = User.all.where("status = true").count
    @inactive_user = User.all.where("status = false").count
  end

  def change_status
    @user = User.find(params["id"])
    # @user.status, @user.status.class
    @user.status = params["status"]
    @user.save
    flash[:notice] =  "User status was successfully changed to #{params["status"]}."
    redirect_to @user
  end

  def search
    @users = User.all.select(:first_name, :last_name, :id)
    if params["commit"] == "Search"
      @users = @users.where("lower(first_name) LIKE '%#{params["query"].downcase}%'").
            or(User.where("lower(last_name) LIKE '%#{params["query"].downcase}%'"))
    end
    render "users/index" 
  end

  # GET /users or /users.json
  def index
    puts "Params #{params}"
    @users = User.all.select(:first_name, :last_name, :id)
    if params["status"] == "false"
      @users = @users.where(status: false)
    elsif params["status"] == "true"
      @users = @users.where(status: true)
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      unless params[:id] == "search"
        @user = User.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :password, :status, :email, :contact, :current_address)
    end

    def check_status
      puts "Params #{params}"
      if User.find(params["id"]).status == false
        puts "Yooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
        flash[:notice] = "You must be active to access this section"
      end
      puts "End"
    end

    def check_user
      puts User.find(params["id"]).first_name
      yield
    end
end
