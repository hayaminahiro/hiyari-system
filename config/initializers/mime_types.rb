# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

# Mime::Type.register "application/pdf", :pdf

WickedPdf.config = {
    :exe_path => "#{Gem.loaded_specs['wkhtmltopdf-binary'].full_gem_path}/bin/wkhtmltopdf"
}