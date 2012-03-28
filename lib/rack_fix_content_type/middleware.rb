module RackFixContentType
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      fix_content_type(env["rack.request.form_hash"]) if env["rack.request.form_hash"] && env["REQUEST_METHOD"] == "POST"
      @app.call(env)
    end

    protected

    def fix_content_type(params)
      params.each do |key,param|
        next unless param.instance_of?(Hash)
        next fix_content_type(param) unless param[:tempfile] && param[:tempfile].respond_to?(:path)
        param[:type] = content_type(param[:tempfile].path, param[:filename])
      end
    end

    # blatantly stolen from lib/paperclip/upfile.rb
    def content_type(path, filename)
      type = (filename.match(/\.(\w+)$/)[1] rescue "octet-stream").downcase
      case type
      when %r"jp(e|g|eg)"            then "image/jpeg"
      when %r"tiff?"                 then "image/tiff"
      when %r"png", "gif", "bmp"     then "image/#{type}"
      when "txt"                     then "text/plain"
      when %r"html?"                 then "text/html"
      when "js"                      then "application/js"
      when "csv", "xml", "css"       then "text/#{type}"
      else
        # On BSDs, `file` doesn't give a result code of 1 if the file doesn't exist.
        content_type = (`file -b --mime-type #{path}`.split(':').last.strip rescue "application/x-#{type}")
        content_type = "application/x-#{type}" if content_type.match(/\(.*?\)/)
        content_type
      end
    end
  end
end
