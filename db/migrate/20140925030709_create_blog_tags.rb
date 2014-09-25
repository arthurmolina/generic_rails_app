class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
