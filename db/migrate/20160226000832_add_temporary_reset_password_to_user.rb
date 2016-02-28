class AddTemporaryResetPasswordToUser < ActiveRecord::Migration
  def change
  	add_column :users, :temporarypassword, :string, nil: "", default: ""
  end
end
