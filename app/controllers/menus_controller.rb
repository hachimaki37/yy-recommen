class MenusController < ApplicationController
  def index
    @menus = Menu.all.page(params[:page]).per(15)
  end

  def new
    @menus = Menu.new
  end

  def create
    @menu = Menu.create(menu_params)
    @menu.user = current_user
    if @menu.save
      flash[:success] = '投稿が完了しました'
      redirect_to menus_path
    else
      flash[:danger] = '投稿が失敗しました'
      redirect_to new_menu_path
    end
  end

  def show

  end

  private

  def menu_params
    params.require(:menu).permit(:name, :recommend_title, :description)
  end
end
