//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Matthew Brown on 3/22/15.
//  Copyright (c) 2015 Crest Technologies. All rights reserved.
//

import Foundation

class RecordedAudio
{
    var title: String
    var filePathURL: NSURL
    
    init(title: String, filePath: NSURL) {
        self.title = title
        self.filePathURL = filePath
    }
}
