/*
 MacWolfEd: Wolf3D editor for Mac
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
// Error handling
//
public enum DataReaderError: Error {
    case endOfData
}

//
// Data stream reader. Supports endianness (default: LE)
//
public class DataReader {
    private let data: Data  // the data to read
    private var position = 0

    //
    // init with data
    //
    public init(data: Data) {
        self.data = data
    }

    //
    // Returns 2 bytes. Throws if out of bounds.
    //
    public func readUInt16() throws -> UInt16 {
        if position + 1 >= data.count {
            throw DataReaderError.endOfData
        }
        position += 2
        return UInt16(data[position - 2]) + (UInt16(data[position - 1]) << 8)
    }

    //
    // Returns 4 bytes
    //
    public func readInt32() throws -> Int32 {
        if position + 3 >= data.count {
            throw DataReaderError.endOfData
        }
        position += 4
        return Int32(data[position - 4]) + (Int32(data[position - 3]) << 8) +
            (Int32(data[position - 2]) << 16) + (Int32(data[position - 1]) << 24)
    }

    //
    // Returns an array of such bytes
    //
    public func readUInt16Array(count: Int) throws -> [UInt16] {
        var result = [UInt16]()
        for _ in stride(from: 0, to: count, by: 1) {
            result.append(try readUInt16())
        }
        return result
    }

    //
    // Returns an array of such bytes
    //
    public func readInt32Array(count: Int) throws -> [Int32] {
        var result = [Int32]()
        for _ in stride(from: 0, to: count, by: 1) {
            result.append(try readInt32())
        }
        return result
    }

    //
    // Seeks to a position
    //
    public func seek(position: Int) throws {
        if position > data.count || position < 0 {
            throw DataReaderError.endOfData
        }
        self.position = position
    }
}
