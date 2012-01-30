class DeviseAddResetPasswordSentAt < ActiveRecord::Migration
  def up
    add_column :users, :reset_password_sent_at, :string
  end

  def down
    remove_column :users, :reset_password_sent_at
  end
end
