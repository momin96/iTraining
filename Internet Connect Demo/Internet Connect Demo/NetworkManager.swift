//
//  NetworkManager.swift
//  Internet Connect Demo
//
//  Created by Nasir Ahmed Momin on 08/06/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation


enum ConnectionType {
    case typeNone
    case typeWifi
    case typeCellular
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var reachability: Reachability?
    private let hostName = "www.google.com"
    
    init() {
        print("init")
        self.configNetwork()
    }
    
    deinit {
        unregisterReachabilityObserver()
    }
    
    private func configNetwork () {
        print("configNetwork")
        reachability = Reachability(hostname: hostName)
        registerReachablityObserver()
    }
    
    private func registerReachablityObserver () {
        print(" Register ")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChangedNotification(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
    }
    
    private func unregisterReachabilityObserver () {
        print(" Unregister ")

        NotificationCenter.default.removeObserver(self,
                                                  name: .reachabilityChanged,
                                                  object: nil)
    }
    
    private func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            print("Issue in startNotifier")
            return
        }
    }
    
    @objc private func reachabilityChangedNotification(_ note : Notification) {
    
        let reachability = note.object as! Reachability
        
        if reachability.connection != .none {
            print(" network reachable ")
        } else {
            print(" network un reachable ")
        }
    }
    
    private func stopNotifier() {
        print("--- stop notifier")
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    public func isNetworkAvailable () -> Bool {
        
        if reachability?.connection == .wifi {
            return true
        }
        if reachability?.connection == .cellular {
            return true
        }
        
        return false
    }
    
    public func isWifiConnection() -> Bool {
        if reachability?.connection == .wifi {
            return true
        }
        return false
    }
    
    public func isCellularConnection() -> Bool {
        if reachability?.connection == .cellular {
            return true
        }
        
        return false
    }
    
    public func currentConnectionType () -> ConnectionType {
        
        if reachability?.connection == .wifi {
            return .typeWifi
        }
        if reachability?.connection == .cellular {
            return .typeCellular
        }

        return .typeNone
    }
}
