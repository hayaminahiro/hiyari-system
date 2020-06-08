class StaticPagesController < ApplicationController
  def top
    @facility = Facility.new
  end

  def logout
    FacilityMfaSession.destroy
    redirect_to :root
  end
end
