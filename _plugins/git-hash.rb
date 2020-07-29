module Jekyll
  class GitHashGenerator < Generator
    priority :high
    safe true
    def generate(site)
      site.data['git-hash'] = %x( git rev-parse HEAD ).strip
    end
  end
end
