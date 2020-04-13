class Snippet < ApplicationRecord
  belongs_to :language, required: true

  def serializable
    SnippetSerializer.new(self)
  end

  def serialize
    serializable.to_h
  end

  def highlighted
    language_label = "<span style='position: absolute; top: -13px; right: 25px; border: 1px solid lightgrey; font-family: monospace; padding: 4px 10px; background-color: snow;'>#{ language.name }</span>"
    
    language_label + Pygments.highlight(
      body,
      lexer: 'rb',
      options: { encoding: 'utf-8', linenos: true }
    ).html_safe
  end
end
