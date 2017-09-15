
// JSONEncoder、JSONDecoder的userinfo的使用

import UIKit

func encode<T>(_ model: T, _ options: [CodingUserInfoKey: Any]!) throws -> String where T: Codable
{
    let encoder = JSONEncoder()
    
    encoder.outputFormatting = .prettyPrinted
    
    encoder.userInfo = options
    
    let data = try encoder.encode(model)
    
    return String(data: data, encoding: .utf8)!
}

func decode<T>(_ json: String, _ type: T.Type, _ options: [CodingUserInfoKey: Any]!) throws -> T where T: Codable
{
    let decoder = JSONDecoder()
    
    decoder.userInfo = options
    
    let data = json.data(using: .utf8)!
    
    return try decoder.decode(type.self, from: data) as T
}

struct MusicModelOptions
{
    enum Version
    {
        case v1
        case v2
    }
    
    var version: Version
    var dateFormatter: DateFormatter
    {
        let formatter = DateFormatter()
        switch version {
        case .v1: formatter.dateFormat = "yyyy-MM-dd"
        case .v2: formatter.dateFormat = "yyyy-MMM-dd hh:mm:ssZ"
        }
        
        return formatter
    }
    
    // Codable的encoder/decoder的userinfo是一个[CodingUserInfoKey : Any]，所以这里生成一个固定的key
    static let infoKey = CodingUserInfoKey(rawValue: "just for key")!
}

struct Music: Codable
{
    var createdAt: Date
    
    private enum CodingKeys: String, CodingKey
    {
        case createdAt = "created_at"
    }
    
    init(createdAt: Date)
    {
        self.createdAt = createdAt
    }
}

extension Music
{
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let options = decoder.userInfo[MusicModelOptions.infoKey] as? MusicModelOptions
        {
            let formatter = options.dateFormatter
            let dateString = try container.decode(String.self, forKey: .createdAt) // Date储存成了String对象
            let date = formatter.date(from: dateString)!
            self.init(createdAt: date)
        }
        else
        {
            fatalError("decode fail")
        }
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let options = encoder.userInfo[MusicModelOptions.infoKey] as? MusicModelOptions
        {
            let formatter = options.dateFormatter
            let dateString = formatter.string(from: createdAt)
            try container.encode(dateString, forKey: .createdAt) // Date储存成了String对象
            
        }
        else
        {
            fatalError("encode fail")
        }
    }
}

do
{
    let options = MusicModelOptions(version: .v2)
    
    let model = Music(createdAt: Date())
    
    let jsonString = try encode(model, [MusicModelOptions.infoKey: options])
    print(jsonString)
    
    let decodeModel = try decode(jsonString, Music.self, [MusicModelOptions.infoKey: options])
    dump(decodeModel)
}
catch
{
    print(error)
    
}
