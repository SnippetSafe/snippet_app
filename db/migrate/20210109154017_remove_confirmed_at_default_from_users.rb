class RemoveConfirmedAtDefaultFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :confirmed_at, nil
  end
end
