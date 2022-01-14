class RestaurantsController < ApplicationController
  # トップ画面遷移
  def top
  end

  # 店舗検索
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

  # 店舗登録画面
  def new
    @restaurant = Restaurant.new
  end

  # 店舗登録処理
  def create
    binding.pry
    @restaurant = Restaurant.new(restaurant_param)
    if @restaurant.save
      flash[:notice] = "店舗情報を登録しました"
      redirect_to restaurant_path(id: @restaurant)
    else
      render "new"
    end
  end

  # 店舗詳細
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private
  # 店舗登録パラメータ
  def restaurant_param
    params.require(:restaurant).permit(:restaurant_name, :tel, :zipcode, :address, :restaurant_image, :registered_user_id)
  end

end
