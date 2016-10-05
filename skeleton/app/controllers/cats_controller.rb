class CatsController < ApplicationController

  before_action :validate_ownership, only: [:edit, :update]


  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
      render :edit
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def validate_ownership
    @cat = Cat.find_by_id(params[:id])
    if @cat.owner != current_user
      flash[:errors] = "This ain't your cat"
      redirect_to cats_url
    end
  end

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
