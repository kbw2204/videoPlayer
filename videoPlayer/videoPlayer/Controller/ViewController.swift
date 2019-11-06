//
//  ViewController.swift
//  videoPlayer
//
//  Created by 강병우 on 06/11/2019.
//  Copyright © 2019 강병우. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var videoView: UIView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playStatus: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4") else {
            return
        }
        player = AVPlayer(url: url)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resize
        
        if let playerLayerOptionalBinding = playerLayer {
            videoView.layer.addSublayer(playerLayerOptionalBinding)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoView.bounds
    }
    @IBAction func playButton(_ sender: UIButton) {
        if playStatus {
            player?.pause()
            sender.setTitle("일시 정지", for: .normal)
        } else {
            player?.play()
            sender.setTitle("재생", for: .normal)
        }
        playStatus = !playStatus
    }
    @IBAction func forwardButton(_ sender: UIButton) {
        guard let duration = player?.currentItem?.duration else {
            return
        }
        guard let playerOptionalBinding = player else {
            return
        }
        let currentTime = CMTimeGetSeconds(playerOptionalBinding.currentTime())
        let newTime = currentTime + 5.0
        if newTime < (CMTimeGetSeconds(duration) - 5.0) {
            let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player?.seek(to: time)
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        guard let playerOptionalBinding = player else {
            return
        }
        let currentTime = CMTimeGetSeconds(playerOptionalBinding.currentTime())
        var newTime = currentTime - 5.0
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player?.seek(to: time)
    }
    
}


