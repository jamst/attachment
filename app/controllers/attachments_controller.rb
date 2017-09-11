 class AttachmentsController < ApplicationController
  before_action :set_attachment

  def new
    
  end

  def create
    ActiveRecord::Base.transaction do 
      @entity.attachments.create(permitted_attachment)
      @entity.save_audits(operator_type: 'User', operator_id: current_user.id, note: @tag )
    end
    render :new
  end

  def destroy
    ActiveRecord::Base.transaction do 
      attachment = Attachment.find(params[:id])
      attachment.delete
      @entity.save_audits(operator_type: 'User', operator_id: current_user.id, note: @tag )
    end
    render :new
  end

  private

  def set_attachment
    @entity = params[:entity].constantize.find(params[:entity_id])
    @tag = params[:tag]
  end

  def permitted_attachment
    params.require(:attachment).permit(:path,:tag)
  end

end