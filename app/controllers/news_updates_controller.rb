# frozen_string_literal: true

class NewsUpdatesController < ApplicationController
  before_action :admin_only, except: [:index]
  respond_to :html
  respond_to :json, only: %i[index]

  def index
    @news_updates = NewsUpdate.includes(:creator).order("id desc").paginate(params[:page], limit: params[:limit])
    respond_with(@news_updates)
  end

  def new
    @news_update = NewsUpdate.new
    respond_with(@news_update)
  end

  def edit
    @news_update = NewsUpdate.find(params[:id])
    respond_with(@news_update)
  end

  def create
    @news_update = NewsUpdate.create(news_update_params)
    respond_with(@news_update, location: news_updates_path)
  end

  def update
    @news_update = NewsUpdate.find(params[:id])
    @news_update.update(news_update_params)
    respond_with(@news_update, location: news_updates_path)
  end

  def destroy
    @news_update = NewsUpdate.find(params[:id])
    @news_update.destroy
    respond_with(@news_update, &:js)
  end

  private

  def news_update_params
    params.require(:news_update).permit([:message])
  end
end
