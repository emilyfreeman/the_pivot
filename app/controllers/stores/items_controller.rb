class Stores::ItemsController < StoresController
  def show
    @item = Item.find_by(id: params[:id])
  end
end
