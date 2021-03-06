class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @filterrific = initialize_filterrific(
      User,
      params[:filterrific]
    ) or return
    
    # @users = User.all
    @users = @filterrific.find.page(params[:page]).paginate(page: params[:page], per_page: 10)
    # @users = @filterrific

    @friendships = Friendship.where(:user_id1 => current_user.id)
    @friendship_user2_ids = @friendships.map{ |f| f.user_id2}
    @groups = Group.where(["creator_id = ?", current_user.id])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.where(:user_id1 => current_user.id).where(:user_id2 => @user.id)
    @asked = Question.for_creator(@user.id)
    @answered = Answer.for_answerer(@user.id)
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
    if @user.save
      flash[:success] = "Welcome to Deligo!"
      # Handle a successful save.
      log_in @user
      redirect_to @user

    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number)
    end
end
