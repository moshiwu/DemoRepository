//
// 处理json和model之间层次结构不相同的情况
//

import UIKit

let originString = """
{
    "duration" : 300,
    "info" : {
                "create_by" : "某个歌星",
                "slices" : [50, 120, 180]
            }
}
"""

struct Music: Codable
{
    var duration: Float
    var slices: [Float]

    enum CodingKeys: String, CodingKey
    {
        case name
        case duration
        case info
    }

    // 处理内嵌的类型，需要另外声明一个CodingKey
    enum InfoKeys: String, CodingKey
    {
        case slices
    }

    // 自定义Codable的struct，系统不再合成init
    init(duration: Float, slices: [Float])
    {
        self.duration = duration
        self.slices = slices
    }

    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let duration = try container.decode(Float.self, forKey: .duration)

        let nestedContainer = try container.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)

        // json里面的slices是一个数组，可以用nestedUnkeyedContainer配合isAtEnd来遍历所有元素
        var slices = [Float]()
        var unkeyedContainer = try nestedContainer.nestedUnkeyedContainer(forKey: .slices)
        while !unkeyedContainer.isAtEnd
        {
            let sliceDuration = try unkeyedContainer.decode(Float.self)
            slices.append(sliceDuration / duration)
        }

        self.init(duration: duration, slices: slices)
    }

    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(duration, forKey: .duration)

        var nestedContainer = container.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)

        // 同decode，保存成json数组的可以不需要key
        var unkeyedContainer = nestedContainer.nestedUnkeyedContainer(forKey: .slices)

        for value in slices
        {
            try unkeyedContainer.encode(value * duration)
        }

    }
}

var data: Data

// ------------decoder-------------//
let decoder = JSONDecoder()

data = originString.data(using: .utf8)!
let music1 = try decoder.decode(Music.self, from: data)
dump(music1)

// ------------encoder-------------//
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted // 格式化输出

data = try encoder.encode(music1)
let jsonString = String(data: data, encoding: .utf8)!
print("model to json : \n\(jsonString)")
