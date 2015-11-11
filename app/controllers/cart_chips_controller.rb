class CartChipsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    chip = Chip.find(params[:chip_id])
    @cart.add_chip(chip.id)
    session[:cart] = @cart.contents
    flash[:notice] = "Added Slotachips to cart."
    redirect_to chips_path
  end

  def index
    @chips = CartChip.find_chips(@cart.contents)
    @chips_total = CartChip.chips_total(@chips)
    @cart_total = CartChip.find_total(@chips)
  end

  def update
    chip = Chip.find(params[:id])
    if params[:edit_action] == "add"
      @cart.add_chip(chip.id)
    else
      @cart.subtract_chip(chip.id)
    end
    @chips = CartChip.find_chips(@cart.contents)
    @chips_total = CartChip.chips_total(@chips)
    @cart_total = CartChip.find_total(@chips)
    redirect_to cart_chips_path
  end

  def destroy
    chip = Chip.find(params[:id])
    @cart.contents.delete(params[:id])
    flash[:notice] = "<span style='color: green'>Successfully removed #{view_context.link_to(chip.name, chip_path(chip.slug))} from your cart.</span>"
    redirect_to cart_chips_path
  end
end