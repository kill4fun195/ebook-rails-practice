class AddApproveToComments < ActiveRecord::Migration
  def change
    add_column :comments, :approve, :boolean
  end
end
