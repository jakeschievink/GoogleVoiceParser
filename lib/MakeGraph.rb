require 'pry'
class MakeGraph
  attr_accessor :voiceArray
  def initialize(voiceArray)
    @voiceArray = voiceArray
    @g = Gruff::Area.new('2000x800')
    @g.legend_box_size = 5
    @g.legend_font_size =5
    @g.marker_font_size = 4
  end

  def elementsWithWord(word)
    @voiceArray.keep_if{|e| e["message"].include? word}
  end

  def convertToNameNumber(arr)
    arr.each {|e|
      namehash = {}
      e[:texts].each {|t|
        t.each {|e|
          namehash[t["name"]] = namehash[t["name"]]+1 rescue 1
        }
        e[:texts] = namehash
      }
    }
  end

  def generateGraph(name, amount)
    onlyWords = elementsWithWord(name)
    listOfNamesAndData = {}
    onlyWords.map {|e| listOfNamesAndData[e["name"]] = []}
    seperatedByMonth = onlyWords.group_by {|e| Date.new(e["time"].year, e["time"].month) }  
    organizedList = []
    seperatedByMonth.each {|k,v| organizedList.push({date: k, texts: v}) }
    sortedList = organizedList.sort{|a, b| a[:date] <=> b[:date]}
    sortedByMonthsAndNumbers = convertToNameNumber(sortedList)
    @g.labels = Hash[(0..sortedByMonthsAndNumbers.size).zip sortedList.collect{|e| e[:date].strftime("%m/%y")}]
    sortedByMonthsAndNumbers.each_with_index {|e, i|
        e[:texts].each{|k,v|
          listOfNamesAndData[k][i] = v ||= 0
        }
        listOfNamesAndData.each {|k,v|
          if v[i].nil?
            v[i] = 0
          end
        }
    }
    listOfNamesAndData.each{|k, v| 
      begin 
        if v.reduce(:+) > amount
          @g.data k, v
        end
      rescue
        puts "found nothing in" + k
      end
    }
    @g.write(name+'.png')
  end
end
