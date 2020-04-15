class Language < ApplicationRecord
  has_many :snippets
  has_many :aliases
  has_many :filenames
  has_many :mimetypes

  def self.find_by_filename(filename)
    # change this to an sql query
    matched_fn = Filename.all.find do |fn|
      File.fnmatch(fn.name, filename)
    end

    matched_fn ? matched_fn.language : Language.find_by(name: 'Text only')
  end

  def lexer_alias
    aliases.first.name
  end
end
