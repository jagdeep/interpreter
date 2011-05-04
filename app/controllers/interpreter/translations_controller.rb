class Interpreter::TranslationsController < ApplicationController
  layout "translations"

  def index
    @translations = Interpreter::Translation.all
  end

  def create
    Interpreter::Translation.create(params[:locale], params[:key], params[:value])
    redirect_to interpreter_translations_url, :notice => "Translation added."
  end

end
