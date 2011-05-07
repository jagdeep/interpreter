class Interpreter::TranslationsController < ApplicationController
  layout "translations"

  def index
    @translations = Interpreter::Translation.all
  end

  def new
  end

  def show
    @key = params[:id]
    @translations = Interpreter::Translation.find_all_by_key(@key)
  end

  def create
    Interpreter::Translation.create(params[:locale], params[:key], params[:value])
    redirect_to interpreter_translations_url, :notice => "Translation added."
  end

  def destroy
    Interpreter::Translation.destroy params[:id]
  end

end
