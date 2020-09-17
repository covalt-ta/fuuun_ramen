class Admins::InformationsController < Admins::ApplicationController
  before_action :set_information, only: %i[edit update destroy]

  def create
    @information = current_admin.informations.build(information_params)
    if @information.save
      redirect_to new_admins_product_path, notice: "「#{@information.title}」を作成しました"
    else
      redirect_to new_admins_product_path, alert: '最新情報を作成できませんでした'
    end
  end

  def edit
  end

  def update
    if @information.update(information_params)
      redirect_to admins_products_path, notice: "「#{@information.title}」を更新しました"
    else
      redirect_to admins_products_path, alert: "「#{@information.title}」を更新できませんでした"
    end
  end

  def destroy
    if @information.destroy
      redirect_to admins_products_path, notice: "「#{@information.title}」を削除しました"
    else
      redirect_to admins_products_path, alert: "「#{@information.title}」を削除できませんでした"
    end
  end

  private

  def information_params
    params.require(:information).permit(:title, :text, :image)
  end

  def set_information
    @information = Information.find(params[:id])
  end
end
