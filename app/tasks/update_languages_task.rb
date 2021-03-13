class UpdateLanguagesTask
  def call
    LANGUAGES.each do |lang|
      language = Language.find_or_initialize_by(name: lang[:name])

      language.update!(
        mime_types: lang[:mime] ? [lang[:mime]] : lang[:mimes],
        extensions: lang[:ext] || ['txt']
      )
    end
  end
end