class SearchController < ApplicationController
  before_action :authenticate_stuff!
  authorize_resource
  def search
    @results = Search.search_selection(params[:query], params[:selection])
  end
end
