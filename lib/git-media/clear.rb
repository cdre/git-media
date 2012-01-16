require 'git-media/status'

module GitMedia
  module Clear

    def self.run!
      @push = GitMedia.get_push_transport
      self.clear_local_cache
    end
    
    def self.clear_local_cache
      # find files in media buffer and upload them
      all_cache = Dir.chdir(GitMedia.get_media_buffer) { Dir.glob('*') }
      unpushed_files = @push.get_unpushed(all_cache)
      pushed_files = all_cache - unpushed_files
      pushed_files.each do |sha|
        puts "removing " + sha
        File.unlink(GitMedia.media_path_from_sharef(sha))
      end
    end
    
  end
end
