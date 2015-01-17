class VoiceParser
  attr_accessor :path, :texts
  def initialize(path)
    @path = path
    @texts = Dir[path+"/*"]
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
  def generateArray(page)
    names = extractNames(page)
    messages = extractMessages(page)
    times = extractTimes(page)
    theArray = Array.new
    theHash = Hash.new
    names.each_with_index {|name, index|
      theArray[index] = Hash.[]("name", name, "time", Date.parse(times[index]), "message", messages[index])
    }
    # times.each_with_index {|time, index|
    #   Date.parse(theHash[time] = Hash.[]("name", names[index], "message", messages[index])
    # }
    theArray = theArray.sort {|a, b| a["time"] <=> b["time"]}
    return theArray
  end
  def generateBigArray()
    bigArray = Array.new
    @texts.each_with_index do |e, i|
      workingpage = Nokogiri::HTML(open(e))
      bigArray.push generateArray(workingpage)
      puts i
    end
    return bigArray.flatten
  end
end
