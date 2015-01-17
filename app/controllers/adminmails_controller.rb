class AdminmailsController < ApplicationController
  before_action :set_adminmail, only: [:show, :edit, :update, :destroy]

  # GET /adminmails
  # GET /adminmails.json
  def index
    @adminmails = Adminmail.all
  end

  # GET /adminmails/1
  # GET /adminmails/1.json
  def show
  end

  # GET /adminmails/new
  def new
    @adminmail = Adminmail.new
  end

  # GET /adminmails/1/edit
  def edit
  end

  # POST /adminmails
  # POST /adminmails.json
  def create
    @adminmail = Adminmail.new(adminmail_params)

    respond_to do |format|
      if @adminmail.save
        format.html { redirect_to @adminmail, notice: 'Adminmail was successfully created.' }
        format.json { render :show, status: :created, location: @adminmail }
      else
        format.html { render :new }
        format.json { render json: @adminmail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adminmails/1
  # PATCH/PUT /adminmails/1.json
  def update
    respond_to do |format|
      if @adminmail.update(adminmail_params)
        format.html { redirect_to @adminmail, notice: 'Adminmail was successfully updated.' }
        format.json { render :show, status: :ok, location: @adminmail }
      else
        format.html { render :edit }
        format.json { render json: @adminmail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adminmails/1
  # DELETE /adminmails/1.json
  def destroy
    @adminmail.destroy
    respond_to do |format|
      format.html { redirect_to adminmails_url, notice: 'Adminmail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adminmail
      @adminmail = Adminmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adminmail_params
      params.require(:adminmail).permit(:admin_mail)
    end
end
