sub init()
    print "init()"
    m.timeGridId = m.top.findNode("timeGridId")
    
    renderEpg()
end sub

sub renderEpg()
    print "renderEpg()"
    rawData = ReadAsciiFile("pkg:/source/serverData.json")
    json = ParseJson(rawData)

    parentContent = CreateObject("RoSGnode", "ContentNode")
    'starts_at_array = [1648704000, 1648705800, 1648707600, 1648709400, 1648711200, 1648713000, 1648714800, 1648716600, 1648718400, 1648720200]
    'starts_at_array = [1648704600, 1648706400, 1648708200, 1648710000, 1648711800, 1648713600, 1648715400, 1648717200, 1648719000, 1648720800, 1648722600, 1648724400, 1648726200, 1648728000]
    index_ = 0
    for each channelFromFile in json.channels
        channel = parentContent.createChild("ContentNode")
        channel.title = channelFromFile.name
        channel.hdsmalliconurl = "pkg:/images/separated/youtubeIcon.png"
        temp = 1648540799
        program = channel.createChild("ContentNode")
        for each programFromFile in channelFromFile.program
            program.title = programFromFile.program_title
            print "program.title: "program.title
            program.playDuration = programFromFile.duration
            print "program.playDuration: "program.playDuration
            program.playStart = programFromFile.starts_at
            ' program.playStart = starts_at_array[index_]
            ' index_ = index_ + 1
            program.hdsmalliconurl = "pkg:/images/separated/homeIconColored.png"
            program.fillProgramGaps = true
            if temp > program.playStart
                temp = program.playStart
            end if
            print "program.playStart: "program.playStart
        end for
    end for
    m.timeGridId.content = parentContent
    print "parentContent: "parentContent
end sub

sub onSetFocus(event)
    booleanValue = event.getData()
    m.timeGridId.setFocus(booleanValue)
    print "Inside: onSetFocus(event)"
end sub