import AVFoundations
var speechsynt: AVSpeechSynthesizer = AVSpeechSynthesizer() //initialize the synthesizer
       distancebeforenextturn = 0
        var turnLeft : String = "Take the next left"
        var turnRight : String = "Take the next right"
        var cont : String = "Continue for " + distancebeforenextturn + "feet"
        var continueSpeech:AVSpeechUtterance = AVSPeechUTterance(string: cont)
        if distancebeforenextturn < 20 && turnLeft:
        var nextSpeech:AVSpeechUtterance = AVSpeechUtterance(string: turnLeft )
        if distancebeforenextturn < 20 && turnRight:
        var nextSpeech:AVSpeechUtterance = AVSpeechUtterance(string: turnRight )
        nextSpeech.rate = 1;
        speechsynt.speakUtterance(nextSpeech)
        if distancebeforenextturn > 30
        speechsynt.speakUtterance(continueSpeech)
