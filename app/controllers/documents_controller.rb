class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if params[:search].present? || params[:date_filter].present?
      # @ingoing = Document.search(
      #   params[:search], 
      #   where: {
      #     outgoing: false,
      #     date: {
      #       gte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').beginning_of_day, 
      #       lte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').end_of_day
      #     } 
      #   }, 
      #   order: {created_at: :desc} )
      # @outgoing = Document.search(
      #   params[:search], 
      #   where: {
      #     outgoing: true,
      #     date: {
      #       gte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').beginning_of_day, 
      #       lte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').end_of_day
      #     } 
      #   }, 
      #   order: {created_at: :desc} )

      search = params[:search].present? ? params[:search] : "*"
      where = {}

      # if params[:date_filter].present?
      #   where[:date] = {
      #     gte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').beginning_of_day,
      #     lte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').end_of_day
      #   }
      # end

      # @ingoing = Document.search(search, where.merge(outgoing: false))
      # @outgoing = Document.search(search, where.merge(outgoing: true))

      # search = params[:search].present? ? params[:search] : "*"
      # where = {misspellings: false}

      if params[:date_filter].present?
        where[:date] = {
          gte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').beginning_of_day,
          lte: DateTime.strptime(params[:date_filter], '%m/%d/%Y %l:%M %p').end_of_day
        }
      end

      @ingoing = Document.search( search, where: where.merge(:outgoing => false), order: {created_at: :desc}, misspellings: false )
      @outgoing = Document.search( search, where: where.merge(:outgoing => true), order: {created_at: :desc}, misspellings: false )

    else
      @documents = Document.where(archival: false)
      @ingoing = @documents.where(outgoing: false).order('created_at desc')
      @outgoing = @documents.where(outgoing: true).order('created_at desc')
    end

    respond_to do |format|
      format.html
      format.xlsx {
        render xlsx: "index", filename: "documents_spreadsheet.xlsx"
      }
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

  def archive
    @documents = Document.where(archival: true)
    @ingoing = @documents.where(outgoing: false).order('created_at desc')
    @outgoing = @documents.where(outgoing: true).order('created_at desc')
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
        :letter_date, 
        :received_by, 
        :subject,
        :action_subject,
        :action_done, 
        :gdrive_link,
        :remarks,
        :outgoing,
        :archival,
        :completed,
        :fyi,
        :follow_up,
        :follow_date,
        :folder,
        :urgent,
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
