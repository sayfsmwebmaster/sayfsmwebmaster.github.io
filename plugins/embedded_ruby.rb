# require 'erb'
# require 'recursive-open-struct'

module EmbeddedRuby
  def render_liquid(content, payload, info, path = nil)
    liquid = super(content, payload, info, path)

    site = RecursiveOpenStruct.new(payload.site.to_h,
                                   recurse_over_arrays: true)
    page = RecursiveOpenStruct.new(payload.page,
                                   recurse_over_arrays: true)
    layout = RecursiveOpenStruct.new(payload.layout,
                                     recurse_over_arrays: true)
    content = payload.content
    paginator = RecursiveOpenStruct.new(payload.paginator,
                                        recurse_over_arrays: true)

    ERB.new(liquid).result(binding)
  end
end

module Jekyll
  class Renderer
    prepend EmbeddedRuby
  end
end