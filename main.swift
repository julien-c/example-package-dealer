/*
 This source file is part of the Swift.org open source project

 Copyright 2015 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

#if os(Linux)
import Glibc
srandom(UInt32(clock()))
#endif

import Foundation
import DeckOfPlayingCards
import Swifter


let numberOfCards = 10




let server = demoServer(nil)

do {
    server["json"] = nil // This crashes because of Json serialization
    
    server["cards"] = { request in
        var deck = Deck.standard52CardDeck()
        deck.shuffle()
        
        var body = ""
        for _ in 0..<numberOfCards {
            guard let card = deck.deal() else {
                print("No More Cards!")
                break
            }

            body += " \(card)"
        }
        
        return .OK(.Html(body))
    }
    
    try server.start()
    print("Server has started (port = 8080). Try to connect now...")
    
    while true {
        sleep(1)
    }
} catch {
    print("Server start error: \(error)")
}
