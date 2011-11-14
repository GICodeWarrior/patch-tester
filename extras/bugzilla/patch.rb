module Bugzilla
  class Patch < Attachment
    attr_reader :id

    def initialize(site, id)
      super(site, id)
    end

    def apply(path, params)
      params = params.map {|k, v| "--#{k}" + (v ? "='#{v}'" : '')}
      command = "patch --directory='#{path}' #{params.join(' ')} 2>&1"
      output = IO.popen(command, 'r+') do |io|
        io.write(contents)
        io.close_write

        io.read
      end

      {:status => $?, :output => output}
    end

    def test(path)
      result = nil
      (0..3).each do |strip|
        result = apply(path, 'strip' => strip, 'dry-run' => nil)
        result[:path] = '/'
        result[:strip] = strip
        return result if result[:status] == 0 || result[:status] == 512
      end

      if contents.match(/^--- ([^\t]*)($|\t)/)
        full_filename = $1
        filename = full_filename

        strip = 0
        loop do
          Dir.glob(File.join(path, '**', filename)).each do |match|
            start_in = match[0..-(filename.size + 1)]
            result = apply(start_in, 'strip' => strip, 'dry-run' => nil)
            result[:path] = start_in[path.size..-1]
            result[:strip] = strip
            return result if result[:status] == 0
          end

          if !filename.match(/^[^\/]*\//)
            break
          end
          filename = filename[$&.size..-1]
          strip += 1
        end
      end

      result
    end
  end
end
