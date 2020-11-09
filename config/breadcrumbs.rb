crumb :root do
  link "トップ", root_path
end

crumb :products do
  link "商品一覧", products_path
  parent :root
end

crumb :product_show do |product|
  link product.name, product_path
  parent :products
end

crumb :user_registrations do
  link "新規登録", new_user_registration_path
  parent :root
end

crumb :user_sessions do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :user_mypage do |user|
  link user.nickname, user
  parent :root
end

crumb :user_new_card do |user|
  link "クレジットカード登録", new_card_path
  parent :user_mypage, user
end

crumb :user_new_address do |user|
  link "住所登録", new_address_path
  parent :user_mypage, user
end

crumb :user_basket do |user|
  link "買い物かご", basket_path
  parent :user_mypage, user
end

crumb :user_new_reservation do |user|
  link "来店日時の選択", new_reservation_charges_path
  parent :user_basket, user
end

crumb :user_new_charge do |user|
  link "購入確認", new_charge_path
  parent :user_new_reservation, user
end

crumb :user_rooms do |user|
  link "チャット一覧", rooms_path
  parent :user_mypage, user
end

crumb :user_message_room do |user|
  link "チャット詳細"
  parent :user_rooms, user
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
