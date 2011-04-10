Dummy::Application.routes.draw do
  match 'fix_content_type' => 'fix_content_type#check_content_type'
end
