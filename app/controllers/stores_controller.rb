class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find_by(slug: params[:store])
    render layout: 'wide'
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      current_user.update(store_id: @store.id)
      flash[:notice] = "#{current_user.first_name} you have submitted business #{@store.name}. Please wait while we review your business"
      redirect_to dashboard_path
    else
      flash.now[:error] = @store.errors.full_messages.join(', ')
      render :new
    end
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
