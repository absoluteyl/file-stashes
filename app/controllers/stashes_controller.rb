class StashesController < ApplicationController
  def index
    @stashes = Stash.all
  end

  def new
    @stash = Stash.new
  end

  def create
    stash = Stash.create!(stash_params)
    redirect_to root_path
  end

  def destroy
    stash = Stash.find(params[:id])
    stash.destroy
    redirect_to root_path
  end

  private

  def stash_params
    params.require(:stash).permit(:attachment)
  end
end
