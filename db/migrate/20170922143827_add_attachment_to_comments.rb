class AddAttachmentToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :attachment, :string
  end
end
