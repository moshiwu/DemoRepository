
// 处理key个数不确定的JSON

import UIKit

let response = """
{
    "1":{
        "title": "Episode 1"
    },
    "2": {
        "title": "Episode 2"
    },
    "3": {
        "title": "Episode 3"
    }
}
"""

struct Episodes: Codable
{
    var list = [Episode]()

    // 首先要定义key value的规则
    struct EpisodeInfo: CodingKey
    {
        var stringValue: String

        init?(stringValue: String)
        {
            self.stringValue = stringValue
        }

        // 后面只用到stringValue，所以intValue忽略
        var intValue: Int? { return nil }

        init?(intValue: Int)
        {
            return nil
        }

        static let title = EpisodeInfo(stringValue: "title")!
    }

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: EpisodeInfo.self)

        print("allKeys: \(container.allKeys)")

        self.list = try container
            .allKeys // allKeys : [1, 2, 3]
            .map
        {
            (key: EpisodeInfo) -> Episode in

            let innerContainer = try container.nestedContainer(keyedBy: EpisodeInfo.self, forKey: key)

            let title = try innerContainer.decode(String.self, forKey: .title)

            return Episode(index: Int(key.stringValue)!, title: title)

        }
        .sorted(by: { $0.index < $1.index })

    }

    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: EpisodeInfo.self)

        for episode in self.list
        {
            let index = EpisodeInfo(stringValue: String(episode.index))!
            var nested = container.nestedContainer(keyedBy: EpisodeInfo.self, forKey: index)
            try nested.encode(episode.title, forKey: EpisodeInfo.title)
        }
    }
}

struct Episode: Codable
{
    var index: Int
    var title: String
}

func encode<T>(of model: T) throws where T: Codable
{
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try encoder.encode(model)
    print(String(data: data, encoding: .utf8)!)
}

func decode<T>(response: String, of: T.Type) throws -> T where T: Codable
{
    let data = response.data(using: .utf8)!
    let decoder = JSONDecoder()

    let model = try decoder.decode(T.self, from: data)

    dump(model)
    return model
}

do
{
    let model = try decode(response: response, of: Episodes.self)
    try encode(of: model)
    //    print(encodedString)
}
catch
{
    print(error)
}
