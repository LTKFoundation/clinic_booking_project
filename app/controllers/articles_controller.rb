class ArticlesController < ApplicationController
  before_action :authenticate_doctor!, only: [:new, :create, :update, :destroy]
  def index
    @doctor = Doctor.find(params[:doctor_id])
    @articles = Article.where(doctor_id: @doctor.id)
  end

  def show
    @doctor = Doctor.find(params[:doctor_id])
    @article = Article.find(params[:id])
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @article = Article.new 
  end

  def create
    @article = Article.new article_params
    @article.save
  end

  def update
  end

  def destroy
  end


  private
    def article_params
      params.require(:article).permit(:title, :content, :doctor_id)
    end
end
