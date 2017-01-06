class EmailSubscriptionsController < ApplicationController

  def create
    @subscriber = EmailSubscription.new(email_params)
    if @subscriber.valid?
      @subscriber.save
      respond_to do |format|
        format.json { render :json => {:message => "Thank you for subscribing!"} }
      end
    else
      respond_to do |format|
        format.json { render :json => {:message => "test"} }
      end
    end
  end

  private

  def email_params
    params.permit(:email)
  end

end
