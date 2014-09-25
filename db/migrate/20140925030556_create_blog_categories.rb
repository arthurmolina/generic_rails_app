class CreateBlogCategories < ActiveRecord::Migration
  def change
    create_table :blog_categories do |t|
      t.string  :name
      t.string  :slug
      t.integer :parent_id
      t.text    :description

      t.timestamps
    end
  end
end
