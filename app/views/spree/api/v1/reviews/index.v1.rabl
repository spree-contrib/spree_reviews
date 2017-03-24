object false
child(@reviews => :reviews) do
  extends "spree/api/v1/reviews/show"
end
node(:count) { @reviews.count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:pages) { @reviews.total_pages }