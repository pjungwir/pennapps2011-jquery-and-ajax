class SlidesController < ApplicationController

  def show
    @slide = Slide.find_by_sort_order(params[:id])
  end

end
