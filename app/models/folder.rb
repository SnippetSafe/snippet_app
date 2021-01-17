class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_many :snippet_folders, dependent: :destroy
  has_many :snippets, through: :snippet_folders

  def popover_options_for(user)
    options = []

    options << { type: :link, title: 'Go to folder', url: folder_path(self) }
    options << { type: :modal, title: 'Add snippet', url: new_modals_snippet_path(folder_id: id) }
    options << { type: :link, title: 'Rename folder', url: edit_folder_path(self) }

    if snippets.empty?
      options << { type: :alert, title: 'Delete', url: delete_alerts_folder_path(self) }
    end

    options
  end

  def client_id
    "folder_#{id}"
  end
end
