/*
 CommonSwift library
 Copyright (C) 2018  Ioan Chera

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import Foundation

//
// Namespace
//
public enum Compress {

    private static let nearTag = 0xa7
    private static let farTag = 0xa8

    //
    // Expand Carmack-like
    // Length is the length of the EXPANDED data
    //
    public static func carmackExpand(source: Data, length lengthBytes: Int) throws -> [UInt16] {
        var length = lengthBytes / 2

        let reader = DataReader(data: source)

        var ch: UInt16
        var chhigh: UInt16
        var count: UInt16
        var offset: UInt16

        var copypos: Int

        var result = [UInt16]()

        while length > 0 {
            ch = try reader.readUInt16()
            chhigh = ch >> 8
            if chhigh == nearTag {
                count = ch & 0xff
                if count == 0 {
                    ch |= UInt16(try reader.readUInt8())
                    result.append(ch)
                    length -= 1
                } else {
                    offset = UInt16(try reader.readUInt8())
                    copypos = result.count - Int(offset)
                    length -= Int(count)
                    if length < 0 {
                        return result
                    }

                    while count != 0 {
                        count -= 1
                        result.append(result[copypos])
                        copypos += 1
                    }
                }
            } else if chhigh == farTag {
                count = ch & 0xff
                if count == 0 {
                    ch |= UInt16(try reader.readUInt8())
                    result.append(ch)
                    length -= 1
                } else {
                    offset = try reader.readUInt16()
                    copypos = Int(offset)
                    length -= Int(count)
                    if length < 0 {
                        return result
                    }

                    while count != 0 {
                        count -= 1
                        result.append(result[copypos])
                        copypos += 1
                    }
                }
            } else {
                result.append(ch)
                length -= 1
            }
        }
        return result
    }

    //
    // RLEW encoding. Length is expanded length
    //
    public static func rlewExpand(source: [UInt16], length: Int, tag: UInt16) -> [UInt16] {
        var result = [UInt16]()
        var pos = 0
        var value, count: UInt16
        repeat {
            value = source[pos]
            pos += 1
            if value != tag {
                result.append(value)
            } else {
                count = source[pos]
                value = source[pos + 1]
                pos += 2
                for _ in stride(from: 0, to: count, by: 1) {
                    result.append(value)
                }
            }
        } while result.count < length

        return result
    }
}
