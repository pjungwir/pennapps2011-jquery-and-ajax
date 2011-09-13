class Admin::SlidesController < ApplicationController

  before_filter :require_http_basic_authentication

  def index
  end

  def new
    @slide = Slide.new
  end

  def edit
    @slide = object
  end

  def create
    @slide = Slide.new(params[:slide])
    @slide.sort_order = Slide.next_sort_order
    if @slide.save
      flash[:success] = 'Slide created'
      redirect_to admin_slides_path
    else
      flash[:error] = @slide.errors.full_messages
      redirect_to new_admin_slide_path
    end
  end

  def update
    @slide = object
    if @slide.update_attributes(params[:slide])
      flash[:success] = 'Slide updated'
      redirect_to admin_slides_path
    else
      flash[:error] = @slide.errors.full_messages
      redirect_to edit_admin_slide_path @slide
    end
  end

  def destroy
    @slide = object
    if @slide.destroy
      flash[:success] = 'Slide deleted'
      redirect_to admin_slides_path
    else
      flash[:error] = @slide.errors.full_messages
      redirect_to admin_slides_path
    end
  end

  def decrement
    object.move_up
    redirect_to admin_slides_path
  end

  def increment
    object.move_down
    redirect_to admin_slides_path
  end

  protected

  def object
    @slide = Slide.find_by_sort_order(params[:id])
  end

  def require_http_basic_authentication
    logger.info("Asking for HTTP basic authentication")
    authenticate_or_request_with_http_basic do |username, password|
      (username == 'pjungwir' && password == "ts'ailun")
    end
  end

end
