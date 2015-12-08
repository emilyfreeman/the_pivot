class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find_by(slug: params[:store])
    render layout: 'wide'
  end

  def new
  end

  def create
  end

  def edit
    @store = Store.find(current_user.store.id)
  end

  def update
    @store = Store.find(current_user.store.id)
    @store.update(store_params)
    if @store.save
      redirect_to store_dashboard_index_path(current_user.store)
    else
      render :edit
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :bio, :image)
  end
end
