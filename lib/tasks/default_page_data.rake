namespace :db do
  desc "Fill database with home page"
  task populate: :environment do
    page = Rhinoart::Page.new(name: "Home page", slug: "index")

    page.page_content.build(name: 'main_content', content: '<p>Simple text for index page</p>')
    page.page_field.build(name: "title", ftype: "title", position: 0, value: 'Home page')
    page.page_field.build(name: "h1", ftype: "title", position: 1, value: 'Home page' )
    page.page_field.build(name: "description", ftype: "meta", position: 2, value: 'This is a home page')
    page.page_field.build(name: "keywords", ftype: "meta", position: 3, value: 'home, page')
    page.save

    # 99.times do |n|
    #   name  = Faker::Name.name
    #   slug = Faker::Base.flexible(name).downcase.gsub(' ', '-').gsub('.', '')
    #   Page.create!(name: name,
    #                slug: slug)
    # end
  end
end