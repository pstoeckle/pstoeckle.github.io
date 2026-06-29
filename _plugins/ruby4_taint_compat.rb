# Compatibility shim for Ruby versions where taint APIs were removed.
# Jekyll 3.x with Liquid 4 still calls `tainted?` during render.
class Object
  unless method_defined?(:tainted?)
    def tainted?
      false
    end
  end

  unless method_defined?(:taint)
    def taint
      self
    end
  end

  unless method_defined?(:untaint)
    def untaint
      self
    end
  end
end

# Ruby 4 tightened keyword argument forwarding. Pathutil 0.16.2 passes
# keyword hashes positionally, which breaks Jekyll 3.9.0 in `jekyll serve`.
if defined?(Pathutil)
  class Pathutil
    def read(*args, **kwd)
      kwd[:encoding] ||= encoding

      if normalize[:read]
        File.read(self, *args, **kwd).encode(
          universal_newline: true
        )
      else
        File.read(self, *args, **kwd)
      end
    end

    def binread(*args, **kwd)
      kwd[:encoding] ||= encoding

      if normalize[:read]
        File.binread(self, *args, **kwd).encode(
          universal_newline: true
        )
      else
        File.read(self, *args, **kwd)
      end
    end

    def readlines(*args, **kwd)
      kwd[:encoding] ||= encoding

      if normalize[:read]
        File.readlines(self, *args, **kwd).encode(
          universal_newline: true
        )
      else
        File.readlines(self, *args, **kwd)
      end
    end

    def write(data, *args, **kwd)
      kwd[:encoding] ||= encoding

      if normalize[:write]
        File.write(
          self,
          data.encode(crlf_newline: true),
          *args,
          **kwd
        )
      else
        File.write(self, data, *args, **kwd)
      end
    end

    def binwrite(data, *args, **kwd)
      kwd[:encoding] ||= encoding

      if normalize[:write]
        File.binwrite(
          self,
          data.encode(crlf_newline: true),
          *args,
          **kwd
        )
      else
        File.binwrite(self, data, *args, **kwd)
      end
    end
  end
end
