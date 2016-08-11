class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.all
  end

  def new
    @attachment = Attachment.new
  end

  def show
    @attachment = Attachment.find_by(id: params[:id])
  end

  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.save
    redirect_to @attachment
  end

private
  def attachment_params
    params.require(:attachment).permit(:resource_id, :url, :attachment_type_id)
  end



end
