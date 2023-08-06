//
//  University.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/07/07.
//

import Foundation

struct Univ: Codable{
    let webPage: [String]
    let domains: [String]
    let country: String
    let name: String
    let state: String?
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case webPage = "web_pages"
        case domains
        case country
        case name
        case state = "state-province"
        case code = "alpha_two_code"
    
    }
}


