class Snippet < ApplicationRecord
  belongs_to :language, required: true

  def serializable
    SnippetSerializer.new(self)
  end

  def serialize
    serializable.to_h
  end

  def highlighted
    Pygments.highlight(
      body,
      lexer: 'rb',
      options: { encoding: 'utf-8', linenos: true }
    ).html_safe
  end
end
