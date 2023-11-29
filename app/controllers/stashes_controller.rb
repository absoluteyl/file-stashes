class StashesController < ApplicationController
  before_action :get_stash, only: [:show, :destroy]

  def index
    @stashes = Stash.all
  end

  def show
  end

  def new
    @stash = Stash.new
  end

  def create
    stash = Stash.create!(stash_params)
    redirect_to root_path
  end

  def destroy
    @stash.destroy
    redirect_to stashes_path
  end

  private

  def get_stash
    @stash = Stash.find_by(uuid: params[:uuid])
  end

  def stash_params
    params.require(:stash).permit(:attachment)
  end
end
