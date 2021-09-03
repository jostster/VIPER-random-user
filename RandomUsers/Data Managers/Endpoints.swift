//
//  Endpoints.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//

import Foundation

protocol Endpoint {
	var url: String { get }
}

struct API {
	static let host = "https://randomuser.me"

	enum Endpoints {
		
		enum Users {
			case fetch
			
			var path: String {
				switch self {
				case .fetch:
					return "api"
				}
			}

			public var url: String {
				switch self {
				case .fetch:
					return "\(API.host)/\(path)"
				}
			}
		}

	}
}
