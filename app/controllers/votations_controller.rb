class VotationsController < ApplicationController
  def index
    @votations = Votation.all.order(date: :desc)
  end

  def new
    @votation = Votation.new
  end

  def create
    @votation = Votation.new(votation_params)
    if @votation.save
      render json: { status: 'success', msg: "Votación registrada" }, status: :created
    else
      render json: { status: 'error', msg: @votation.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def votation
      @votation = Votation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def votation_params
      params.require(:votation).permit(:name, :date)
    end
end
