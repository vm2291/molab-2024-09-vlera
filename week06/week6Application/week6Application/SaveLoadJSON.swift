import Foundation

func saveJSON<T: Encodable>(fileName: String, val: T) throws {
    let filePath = try documentPath(fileName: fileName)
    print("saveJSON filePath \(filePath as Any)")
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let jsonData = try encoder.encode(val)
    
    try jsonData.write(to: filePath)
}

func loadJSON<T: Decodable>(_ type: T.Type, fileName: String) throws -> T? {
    let filePath = try documentPath(fileName: fileName)
    
    guard FileManager.default.fileExists(atPath: filePath.path) else {
        print("File does not exist at path \(filePath)")
        return nil
    }
    
    let jsonData = try Data(contentsOf: filePath)
    
    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
    
    return decodedData
}

func documentPath(fileName: String, createIfMissing create: Bool = false) throws -> URL {
    return try FileManager.default.url(for:.documentDirectory,
                                       in:.userDomainMask,
                                       appropriateFor:nil,
                                       create:create).appendingPathComponent(fileName)
}
