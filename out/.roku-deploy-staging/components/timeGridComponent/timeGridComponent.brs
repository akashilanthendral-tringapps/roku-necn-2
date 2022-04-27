sub init()

    m.timeGridId = m.top.findNode("timeGridId")
    
    renderEpg()
end sub

sub renderEpg()

    rawData = ReadAsciiFile("pkg:/source/serverData.json")
    json = ParseJson(rawData)

    parentContent = CreateObject("RoSGnode", "ContentNode")

    for each channelFromFile in json.channels
        channel = parentContent.createChild("ContentNode")
        channel.title = channelFromFile.name
        channel.hdsmalliconurl = "pkg:/images/separated/youtubeIcon.png"
        lowestSTartTime = 1648540799
        program = channel.createChild("ContentNode")
        for each programFromFile in channelFromFile.program
            program.title = programFromFile.program_title
            
            program.playDuration = programFromFile.duration
            
            program.playStart = programFromFile.starts_at
            
            program.hdsmalliconurl = "pkg:/images/separated/homeIconColored.png"
            program.fillProgramGaps = true
            if lowestSTartTime > program.playStart
                lowestSTartTime = program.playStart
            end if
            
        end for
    end for
    m.timeGridId.content = parentContent
    
end sub

sub onSetFocus(event)
    booleanValue = event.getData()
    m.timeGridId.setFocus(booleanValue)
end sub