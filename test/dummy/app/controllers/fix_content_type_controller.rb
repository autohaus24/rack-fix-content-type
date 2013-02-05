class FixContentTypeController < ApplicationController
  def check_content_type
    render :text => params.to_json
  end
end
