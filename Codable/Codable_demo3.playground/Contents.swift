
// Codable 继承关系的处理

import UIKit

class Point2D: Codable
{
    var x = 0
    var y = 0

    private enum CodingKeys: String, CodingKey
    {
        case x
        case y
    }

    public required init(x: Int, y: Int)
    {
        self.x = x
        self.y = y
    }

    public required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.x = try container.decode(Int.self, forKey: .x)
        self.y = try container.decode(Int.self, forKey: .y)

    }

    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }
}

class Point3D: Point2D
{
    var z = 0

    private enum CodingKeys: String, CodingKey
    {
        case z
        case point_2d
    }

    required init(x: Int, y: Int, z: Int)
    {
        self.z = z
        super.init(x: x, y: y)
    }

    required init(x: Int, y: Int)
    {
        super.init(x: x, y: y)
        self.z = 0
    }

    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.z = try container.decode(Int.self, forKey: .z)

        // 调用super的decode方法
        // 继承关系里，可以用一个key把基类的属性包裹起来
        try super.init(from: container.superDecoder(forKey: .point_2d))
        // try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(z, forKey: .z)

        // 调用super的encode方法
        // 继承关系里，可以用一个key把基类的属性包裹起来
        try super.encode(to: container.superEncoder(forKey: .point_2d))
        // try super.encode(to: encoder)
    }
}

func encode<T>(_ model: T) throws -> String where T: Codable
{
    let encoder = JSONEncoder()

    encoder.outputFormatting = .prettyPrinted

    let data = try encoder.encode(model)

    return String(data: data, encoding: .utf8)!
}

func decode<T>(_ json: String, _ type: T.Type) throws -> T where T: Codable
{
    let decoder = JSONDecoder()

    let data = json.data(using: .utf8)!

    return try decoder.decode(type.self, from: data) as T
}

do
{
    let p1 = Point2D(x: 3, y: 4)
    let p2 = Point3D(x: 6, y: 7, z: 8)

    let jsonString = try encode(p2)
    print(jsonString)

    let p3 = try decode(jsonString, Point3D.self)
    dump(p3)
}
catch
{
    print(error)
}
