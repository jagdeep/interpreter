class Interpreter::TranslationsController < ApplicationController
  layout "translations"

  def index
    @translations = InterpreterTranslation.all
  end

  def search
    @translations = InterpreterTranslation.find_like_key params[:query]
    @search_notice = "#{@translations.length} translation#{'s' if @translations.length > 1} found."
    render :action => :index
  end

  def new
    @translation = InterpreterTranslation.new
  end

  def show
    @key = params[:id]
    @translations = InterpreterTranslation.find_all_by_key(@key)
  end

  def create
    @translation = InterpreterTranslation.new
    @translation.locale = params[:interpreter_translation][:locale]
    @translation.key = params[:interpreter_translation][:key]
    @translation.value = params[:interpreter_translation][:value]
    if @translation.save
      redirect_to interpreter_translations_url, :notice => "Translation added."
    else
      render :action => :new
    end
  end

  def destroy
    count = InterpreterTranslation.destroy(params[:id].gsub('-','.'))
    redirect_to interpreter_translations_url, :notice => "#{count} translation#{'s' if count > 1} destroyed."
  end

end
