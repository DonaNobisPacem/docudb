class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if params[:search].present?
      #@bids = Bid.search(params[:search], page: params[:page], per_page: 10)
      @ingoing = Document.search(params[:search], where: {outgoing: false} )
      @outgoing = Document.search(params[:search], where: {outgoing: true} )
    else
      @documents = Document.all
      @ingoing = @documents.where(outgoing: false)
      @outgoing = @documents.where(outgoing: true)
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @attachments = @document.attachments
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /documents/new
  def new
    @document = Document.new
    @attachment = @document.attachments.build
  end

  # GET /documents/1/edit
  def edit
    @attachment = @document.attachments.build unless @document.attachments.count > 0
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        if params[:attachments]
          params[:attachments].each do |a|
            @attachment = @document.attachments.create!(:attachment => a)
          end
        end
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        if params[:attachments]
          params[:attachments].each do |a|
            @attachment = @document.attachments.create!(:attachment => a)
          end
        end
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(
        :control, 
        :office, 
        :date, 
        :received_by, 
        :subject, 
        :outgoing,
        attachments_attributes: [
          :id,
          :attachment,
          :attachment_cache,
          :document_id,
          :_destroy
        ]
      )
    end
end
