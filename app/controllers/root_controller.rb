class RootController < ApplicationController
  
  before_action :authenticate_user!, :except => :index
  
  def index
  end

  def logged
    @channels = Dictionary.where(:obj_type => 'channel')
    @users = Dictionary.where(:obj_type => 'user')
  end
  
  def search
    @result = Message.search do
      fulltext params[:q]
      paginate :page => params[:page]
    end
  end
  
  def context
    @message = Message.find(params[:m_id])
    @older = Message.where(:channel => @message.channel).where(['created_at < ?', @message.created_at]).order('id DESC').limit(5).reverse
    @newer = Message.where(:channel => @message.channel).where(['created_at > ?', @message.created_at]).limit(5)
  end
  
  def channel
    @result = Message.search do
      with :channel, params[:q]
      paginate :page => params[:page]
    end
    render 'search'
  end
  
  def user
    @result = Message.search do
      with :user, params[:q]
      paginate :page => params[:page]
    end
    render 'search' 
  end
end
