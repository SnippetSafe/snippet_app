class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_many :snippet_folders, dependent: :destroy
  has_many :snippets, through: :snippet_folders

  def popover_options_for(user)
    options = []

    options << { type: :modal, title: 'Add snippet', url: new_snippet_modal_snippets_path(folder_id: id) }
    options << { type: :link, title: 'Rename folder', url: edit_folder_path(self) }

    if snippets.empty?
      options << { type: :alert, title: 'Delete', url: delete_alert_folder_path(self) }
    end

    options
  end

  def client_id
    "folder_#{id}"
  end
end
