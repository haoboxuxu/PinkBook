//
//  Protocols.swift
//  PinkBook
//
//  Created by 徐浩博 on 2021/10/8.
//

import Foundation

protocol ChannelVCDelegate {
    /// 笔记选择话题#后反向传值的协议
    /// - Parameter channel: 反向传值channel
    /// - Parameter subChannel: 反向传值subChannel
    func updateChannel(channel: String, subChannel: String)
}
