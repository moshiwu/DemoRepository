import UIKit

// 普通的Codable demo

let originString = """
{
    "create_by" : "某个歌星",
    "create_date" : "2017-09-13",
    "name" : "测试歌曲",
    "type" : "mp4",
    "duration" : "NaN",
    "origin": "5rWL6K+V5YaF5a65"
}
"""

enum MusicType: String, Codable
{
    case mp4
    case wav
}

struct Music: Codable
{
    var name: String // 普通类型默认已经遵循了Codable
    var duration: Float
    var createDate: Date
    var createBy: String
    var type: MusicType
    var origin: Data

    enum CodingKeys: String, CodingKey // 注意"CodingKeys"是内置关键字，swift会通过此关键字自动合成init(from:)和encode(to:)方法
    {
        case name
        case duration
        case createDate = "create_date" // 如果model、json的变量名不相同，可以在这里映射
        case createBy = "create_by"
        case type
        case origin
    }
}

var data: Data

// ------------decoder-------------//
let decoder = JSONDecoder()

// Date类型可以指定编码/解码策略
decoder.dateDecodingStrategy = .custom({
    // 当Codable调用此closure的时候，必然是在encode/decode某个Date变量，所以不需要指定key
    let dateString = try $0.singleValueContainer().decode(String.self)
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: dateString)!
})
// 浮点类型可以指定正无穷、负无穷、NaN的编码/解码策略
decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
// Data类型支持加密/解密，如base64
decoder.dataDecodingStrategy = .base64

data = originString.data(using: .utf8)!
let music1 = try decoder.decode(Music.self, from: data)
dump(music1)
print("base64 string : \(String(data: music1.origin, encoding: .utf8)!)")

// ------------encoder-------------//
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted // 格式化输出
encoder.dateEncodingStrategy = .custom({ date, encoder in
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let dateString = formatter.string(from: date)
    var container = encoder.singleValueContainer() // 同decoder
    try container.encode(dateString)
})
encoder.nonConformingFloatEncodingStrategy = .convertToString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
encoder.dataEncodingStrategy = .base64

data = try encoder.encode(music1)
let jsonString = String(data: data, encoding: .utf8)!
print("model to json : \n \(jsonString)")
