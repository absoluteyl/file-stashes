class StashesController < ApplicationController
  before_action :get_stash,            only: [:show, :share, :destroy]
  before_action :validate_stash_exist, only: [:show, :share, :destroy]

  def index
    @stashes = Stash.all
  end

  def show
  end

  def share
    @stash.generate_uniq_token
    redirect_to stash_path(@stash.uuid)
  end

  def new
    @stash = Stash.new
  end

  def create
    @stash = Stash.new(stash_params)
    if @stash.save
      redirect_to stash_path(@stash.uuid)
    else
      render :new
    end
  end

  def destroy
    @stash.destroy
    redirect_to stashes_path
  end

  private

  def get_stash
    key   = params[:token].present? ? 'token' : 'uuid'
    value = params[key]
    @stash = eval("Stash.find_by_#{key}('#{value}')")
  end

  def validate_stash_exist
    render_not_found unless @stash
  end

  def stash_params
    params.require(:stash).permit(:attachment)
  end
end
