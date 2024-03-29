class MomentumCms::File < ActiveRecord::Base
  # == MomentumCms ==========================================================
  include MomentumCms::BelongsToSite

  self.table_name = 'momentum_cms_files'

  # == Constants ============================================================

  attr_accessor :delete_file

  # == Relationships ========================================================

  belongs_to :attachable,
             polymorphic: true

  # == Extensions ===========================================================

  has_attached_file :file,
                    styles: lambda { |i| i.instance.attachable_styles }

  before_post_process :is_image?

  # == Validations ==========================================================

  validates :identifier, presence: true

  validates :identifier, uniqueness: true

  before_validation { self.file.clear if self.delete_file == '1' }

  do_not_validate_attachment_file_type :file

  # == Scopes ===============================================================
  # == Callbacks ============================================================
  # == Class Methods ========================================================
  # == Instance Methods =====================================================
  def attachable_styles
    {
      _134x134: '134x134>'
    }
  end

  def is_image?
    ['image/jpeg', 'image/pjpeg', 'image/png', 'image/x-png', 'image/gif', 'image/jpg'].include?(self.file_content_type)
  end
end
