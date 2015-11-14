class ProjxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_projx, only: [:show, :edit, :update, :destroy, :contributor_request, :requests, :accept_contributor_request, :remove_contributor]

  # GET /projxes
  # GET /projxes.json
  def index
    @projxes = Projx.all
    @users = User.all
  end

  # GET /projxes/1
  # GET /projxes/1.json
  def show
  end

  # GET /projxes/new
  def new
    @projx = current_user.projxes.build
  end

  # GET /projxes/1/edit
  def edit
  end

  # POST /projxes
  # POST /projxes.json
  def create
    @projx = current_user.projxes.build(projx_params)

    respond_to do |format|
      if @projx.save
        format.html { redirect_to @projx, notice: 'Projx was successfully created.' }
        format.json { render :show, status: :created, location: @projx }
      else
        format.html { render :new }
        format.json { render json: @projx.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projxes/1
  # PATCH/PUT /projxes/1.json
  def update
    respond_to do |format|
      if @projx.update(projx_params)
        format.html { redirect_to @projx, notice: 'Projx was successfully updated.' }
        format.json { render :show, status: :ok, location: @projx }
      else
        format.html { render :edit }
        format.json { render json: @projx.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projxes/1
  # DELETE /projxes/1.json
  def destroy
    @projx.destroy
    respond_to do |format|
      format.html { redirect_to projxes_url, notice: 'Projx was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def contributor_request
    if @projx.contribution_requests.where(:user_id => current_user.id).count < 1
      contribution_request = @projx.contribution_requests.build
      contribution_request.user = current_user
      if contribution_request.save
        redirect_to :back, notice: 'Contribution request made successfully.'
      else
        redirect_to :back, notice: 'There was an error in making your contribution request.'
      end
    else
      redirect_to :back, notice: 'You have already sent a request for this project.'
    end
  end

  def accept_contributor_request
    contribution_request = @projx.contribution_requests.find(params[:request_id])
    unless contribution_request.nil?
      contribution_request.accepted = true
      if contribution_request.save
        if @projx.contribution_requests.count > 0
          redirect_to requests_projx_path(@projx), notice: "Contribution request accepted successfully."
        else
          redirect_to @projx, notice: "Contribution request accepted successfully."
        end
      else
        redirect_to requests_projx_path(@projx), notice: "There was an error in accepting contribution request."
      end
    else
      redirect_to requests_projx_path(@projx), notice: "Could not find this contribution request."
    end
  end

  def remove_contributor
    contribution = @projx.contributions.find(params[:request_id])
    unless contribution.nil?
      if contribution.destroy
        if @projx.contributions.count > 0
          redirect_to requests_projx_path(@projx), notice: "Contributor removed successfully."
        else
          redirect_to @projx, notice: "Contributor removed successfully."
        end
      else
        redirect_to requests_projx_path(@projx), notice: "There was an error in removing contributor."
      end
    else
      redirect_to requests_projx_path(@projx), notice: "Could not find this user's contribution record."
    end
  end

  def requests
    @contribution_requests = @projx.contribution_requests
    @contributions = @projx.contributions
  end

  private

    def authenticate
      :authenticate_user! && current_user.try(:admin?)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_projx
      @projx = Projx.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projx_params
      params.require(:projx).permit(:title, :content, :user_id)
    end
end
