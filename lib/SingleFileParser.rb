class VoiceParser
    attr_accessor :path, :workingpage
    def initialize(path)
        @path = path
        @workingpage = Nokogiri::HTML(open(@path))
    end
    def extractTimes(page)
        times = [] 
        page.css('.message>abbr').each do |time| 
            times << time['title']
        end
        return times
    end
    def extractMessages(page)
        messages = []
        page.css('q').each do |message|
            messages << message.text
        end
        return messages
    end
    def extractNames(page)
        names = []
        page.css('.fn').each do |name|
            names << name.text
        end
        return names
    end
    def generateHash()
        names = extractNames(@workingpage)
        messages = extractMessages(@workingpage)
        times = extractTimes(@workingpage)
        theHash = Hash.new
        names.each_with_index {|name, index|
            theHash[name] = Hash.[]("time", times[index], "message", messages[index])
        }
        return theHash
    end
        

end
