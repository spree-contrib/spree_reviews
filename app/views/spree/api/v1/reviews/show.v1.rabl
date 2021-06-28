object @review
attributes :id, :rating, :title, :review, :show_identifier

node(:name) { |review| review.show_identifier ? review.name : Spree.t(:anonymous) }
node(:email) do |review|
  if review.show_identifier && Spree::Reviews::Config[:show_email] && review.user.present?
    review.user.email
  end
end