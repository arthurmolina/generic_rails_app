class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string    :title
      t.text      :content
      t.integer   :status
      t.integer   :visibility
      t.integer   :format
      t.integer   :image
      t.text      :meta
      t.integer   :created_by
      t.timestamp :published_on

      t.timestamps
    end
  end
end
