class DirectoryParser
    attr_accessor :directory, :names
    def initialize(directoryname)
        @names = []
        @directory = Dir[directoryname+"*Text*"]
    end
    def placeNames()
        @directory.each do |file|

    end
end
