class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/login
  def login
    errorType = ''
    errorInfo = ''
    if @user.username != 'pipi'
      errorType = 'Invalid username'
      errorInfo = 'Username not registered'
    end
    if errorType != ''
      format.html { render :new }
      @user.errors.add(errorType, errorInfo)
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      #@user.first_name.capitalize!
      #@user.last_name.capitalize!

      #if !@user.email.include? '@'
        # @user.errors.add('Invalid email: ', 'Email needs to contain @ character')
        # format.json {render json: @user.errors, status: :unprocessable_entity }
      
      errorType = ''
      errorInfo = ''
      if @user.password.length < 4 or @user.username.length < 4
        errorType = 'Invalid field:'
        errorInfo = 'Username or password is too short (less than 4 characteres).'
      elsif @user.username == @user.password
        errorType = 'Invalid field:'
        errorInfo = 'Username and password cannot be the same.'
      end
      if errorType != ''
        format.html { render :new }
        @user.errors.add(errorType, errorInfo)
        format.json { render json: @user.errors, status: :unprocessable_entity}
      elsif @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
