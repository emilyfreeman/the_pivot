class StoresController < ApplicationController
  def index
  end

  def show
    @store = Store.find_by(slug: params[:store])
    render layout: 'wide'
  end
end
