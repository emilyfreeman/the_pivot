class Platform::StoresController < ApplicationController
  def update
     @store = Store.find(params[:id])
     @store.update_attributes(status: params[:edit_action])
     redirect_to platform_dashboard_index_path
  end
end
