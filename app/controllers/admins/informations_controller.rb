class Admins::InformationsController < Admins::ApplicationController
  before_action :set_information, only: %i(edit update destroy)
  def index
    @informations = Information.all.order(updated_at: :DESC)
  end
  
  def new
    @information = current_admin.informations.build
  end
  
  def create 
    @information = current_admin.informations.build(information_params)
    if @information.save
      redirect_to admins_root_path
    else
      redirect_to action: :new
    end
  end

  def edit
  end

  def update
    if @information.update(information_params)
      redirect_to action: :index
    else
      redirect_to action: :edit
    end
  end

  def destroy
    if @information.destroy
      redirect_to action: :index
    else
      redirect_to action: edit
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
