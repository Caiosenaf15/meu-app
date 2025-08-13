Article.delete_all

user = User.first
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

Category.all.each do |category|
  5.times do
    Article.create!(
      title: "Article #{rand(10000)}",
      body: text,
      category_id: category.id,
      user_id: user.id,
      created_at: rand(365).days.ago,
    )
  end
end

