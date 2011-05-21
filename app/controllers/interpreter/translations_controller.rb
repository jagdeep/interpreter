class Interpreter::TranslationsController < ApplicationController
  layout "translations"

  def index
    @translations = InterpreterTranslation.all
  end

  def search
    @translations = InterpreterTranslation.find_all_by_value_like params[:query]
    @search_notice = "#{@translations.length} translation#{'s' if @translations.length > 1} found."
    render :action => :index
  end

  def new
    @translation = InterpreterTranslation.new
  end

  def create
    @translation = InterpreterTranslation.new params[:interpreter_translation]
    if @translation.save
      redirect_to interpreter_translations_url, :notice => "Translation added."
    else
      render :action => :new
    end
  end

  def edit
    @translation = InterpreterTranslation.find_by_key(params[:id].gsub('-','.'))
  end

  def update
    @translation = InterpreterTranslation.find_by_key(parse_id(params[:id]))
    @translation.update_attributes(params[:interpreter_translation])
    if @translation.save
      redirect_to interpreter_translations_url, :notice => "Translation updated."
    else
      render :action => :edit
    end
  end

  def destroy
    count = InterpreterTranslation.destroy(params[:id].gsub('-','.'))
    redirect_to :back, :notice => "Translation destroyed."
  end

  protected

  def parse_id id
    id.gsub('-','.')
  end
end
