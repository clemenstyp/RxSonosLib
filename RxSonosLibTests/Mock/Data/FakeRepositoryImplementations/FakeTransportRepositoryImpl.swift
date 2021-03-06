//
//  FakeTransportRepositoryImpl.swift
//  Demo App
//
//  Created by Stefan Renne on 26/03/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import Foundation
@testable import RxSonosLib
import RxSwift

class FakeTransportRepositoryImpl: TransportRepository {
    
    func getNowPlaying(for room: Room) -> Observable<Track?> {
        return Observable.just(MusicProviderTrack(sid: 9, flags: nil, sn: nil, queueItem: 7, duration: 265, uri: "x-sonos-spotify:spotify%3atrack%3a2MUy4hpwlwAaHV5mYHgMzd?sid=9&flags=8224&sn=1", imageUri: URL(string: "http://192.168.3.14:1400/getaa?s=1&u=x-sonos-spotify:spotify%3atrack%3a2MUy4hpwlwAaHV5mYHgMzd?sid=9&flags=8224&sn=1")!, description: [TrackDescription.title: "Before I Die", TrackDescription.artist: "Papa Roach", TrackDescription.album: "The Connection"]))
    }
    
    func getNowPlayingProgress(for room: Room) -> Observable<GroupProgress> {
        return Observable.just(GroupProgress(time: 30, duration: 60))
    }
    
    func getTransportState(for room: Room) -> Observable<TransportState> {
        return Observable.just(TransportState.paused)
    }
    
    func getImage(for track: Track) -> Observable<Data?> {
        let image = UIImage(named: "papa-roach-the-connection.jpg", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let data = UIImagePNGRepresentation(image)
        return Observable.just(data)
    }
    
    var nextTrackCounter = 0
    func setNextTrack(for room: Room) -> Observable<Void> {
        nextTrackCounter += 1
        return Observable.just(())
    }
    
    var previousTrackCounter = 0
    func setPreviousTrack(for room: Room) -> Observable<Void> {
        previousTrackCounter += 1
        return Observable.just(())
    }
    
}
