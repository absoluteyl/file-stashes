class StashesController < ApplicationController
  def index
    @stashes = Stash.all
  end
end
