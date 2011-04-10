class FixContentTypeController < ApplicationController
  def check_content_type
    render :text => params.to_yaml
  end
end
