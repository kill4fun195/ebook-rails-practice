class AddAttachmentAvatarUserToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :avatar_user
    end
  end

  def self.down
    remove_attachment :users, :avatar_user
  end
end
