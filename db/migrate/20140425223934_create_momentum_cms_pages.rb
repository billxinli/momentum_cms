class CreateMomentumCmsPages < ActiveRecord::Migration

  def up
    create_table :momentum_cms_pages do |t|
      t.references :site, index: true
      t.references :template, index: true
      t.string :identifier
      t.string :label
      t.integer :published_content_id, index: true
      t.integer :redirected_page_id, index: true
      t.string :ancestry
      t.timestamps
    end
    MomentumCms::Page.create_translation_table! slug: :string, path: :string
  end

  def down
    drop_table :momentum_cms_pages
    MomentumCms::Page.drop_translation_table!
  end

end