//
//  AEXMLDocument+Create.swift
//  RxSonosLib
//
//  Created by Stefan Renne on 12/03/2018.
//  Copyright © 2018 Uberweb. All rights reserved.
//

import Foundation
import AEXML

extension AEXMLDocument {
    class func create(_ data: Data) -> AEXMLDocument? {
        let string = String(data: data, encoding: .utf8)
        return AEXMLDocument.create(string)
    }
    
    class func create(_ string: String?) -> AEXMLDocument? {
        guard let cleanString = string?.removeXmlNamespace() else { return nil }
        return try? AEXMLDocument(xml: cleanString)
    }
    
    func mapMetaItems() -> [[String: String]] {
        return self["DIDL-Lite"].children.map { (item) -> [String: String] in
            return item.children.reduce(into: [String: String](), { (dict, row) in
                dict[row.name] = row.string
                row.attributes.forEach({ (key, value) in
                    dict["\(row.name)\(key)"] = value
                })
            })
        }
    }
}

extension String {
    func mapMetaItem() -> [String: String]? {
        return AEXMLDocument.create(self)?.mapMetaItems().first
    }
    func mapMetaItems() -> [[String: String]]? {
        return AEXMLDocument.create(self)?.mapMetaItems()
    }
}

fileprivate extension String {
    
    func removeXmlNamespace() -> String {
        return self.validateXml().replace(pattern: "<([a-zA-Z]+:)", with: "<").replace(pattern: "</([a-zA-Z]+:)", with: "</")
    }
    
    fileprivate func replace(pattern: String, with template: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return self
        }
        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(0..<self.count), withTemplate: template)
    }
    
}
