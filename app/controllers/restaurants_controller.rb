class RestaurantsController < ApplicationController
  def top
  end

  def search
    # エリアとキーワード両方入力された場合
    if params[:area].present? && params[:keyword].present? 
      @restaurants = Restaurant.where('address LIKE(?) and restaurant_name LIKE(?) or address LIKE(?)', "%#{params[:area]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @recordcount = Restaurant.where('address LIKE(?) and restaurant_name LIKE(?) or address LIKE(?)', "%#{params[:area]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").count
    # エリアのみが入力された場合
    elsif params[:area].present?
      @restaurants = Restaurant.where('address LIKE ?', "%#{params[:area]}%")
      @recordcount = Restaurant.where('address LIKE ?', "%#{params[:area]}%").count
    # キーワードのみが入力された場合
    elsif params[:keyword].present?
      @restaurants = Restaurant.where('restaurant_name LIKE(?) or address LIKE(?)', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @recordcount = Restaurant.where('restaurant_name LIKE(?) or address LIKE(?)', "%#{params[:keyword]}%", "%#{params[:keyword]}%").count
    # 何も入力せずに検索した場合
    else
      @restaurants = Restaurant.all
      @recordcount = Restaurant.count
    end
  end

  def new
    @restaurant = Restaurant.new
  end
end
