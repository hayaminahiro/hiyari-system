class StaticPagesController < ApplicationController
  def top
    @facility = Facility.new
  end
end
