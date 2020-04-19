class Snippet < ApplicationRecord
  belongs_to :language, required: true
  belongs_to :user, required: true

  def serializable
    SnippetSerializer.new(self)
  end

  def serialize
    serializable.to_h
  end

  def language_label
    "<span style='border-radius: 5px; position: absolute; top: -13px; right: 25px; border: 1px solid lightgrey; font-family: monospace; padding: 4px 28px 4px 10px; background-color: snow;'><i style='position: absolute; right: 7px;' class='devicon-ruby-plain colored'></i>#{ language.name }</span>"
  end

  def highlighted
    Pygments.highlight(
      body,
      lexer: language.lexer_alias,
      options: { encoding: 'utf-8', linenos: true }
    ).html_safe
  end
end
