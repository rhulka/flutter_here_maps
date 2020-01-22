// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: map_channel.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct FlutterHereMaps_MapChannelRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var object: OneOf_Object? {
    get {return _storage._object}
    set {_uniqueStorage()._object = newValue}
  }

  ///Map actions
  var setCenter: FlutterHereMaps_MapCenter {
    get {
      if case .setCenter(let v)? = _storage._object {return v}
      return FlutterHereMaps_MapCenter()
    }
    set {_uniqueStorage()._object = .setCenter(newValue)}
  }

  var setConfiguration: FlutterHereMaps_Configuration {
    get {
      if case .setConfiguration(let v)? = _storage._object {return v}
      return FlutterHereMaps_Configuration()
    }
    set {_uniqueStorage()._object = .setConfiguration(newValue)}
  }

  var zoomTo: FlutterHereMaps_ZoomTo {
    get {
      if case .zoomTo(let v)? = _storage._object {return v}
      return FlutterHereMaps_ZoomTo()
    }
    set {_uniqueStorage()._object = .zoomTo(newValue)}
  }

  ///UIMap objects
  var setMapObject: FlutterHereMaps_MapObject {
    get {
      if case .setMapObject(let v)? = _storage._object {return v}
      return FlutterHereMaps_MapObject()
    }
    set {_uniqueStorage()._object = .setMapObject(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Object: Equatable {
    ///Map actions
    case setCenter(FlutterHereMaps_MapCenter)
    case setConfiguration(FlutterHereMaps_Configuration)
    case zoomTo(FlutterHereMaps_ZoomTo)
    ///UIMap objects
    case setMapObject(FlutterHereMaps_MapObject)

  #if !swift(>=4.1)
    static func ==(lhs: FlutterHereMaps_MapChannelRequest.OneOf_Object, rhs: FlutterHereMaps_MapChannelRequest.OneOf_Object) -> Bool {
      switch (lhs, rhs) {
      case (.setCenter(let l), .setCenter(let r)): return l == r
      case (.setConfiguration(let l), .setConfiguration(let r)): return l == r
      case (.zoomTo(let l), .zoomTo(let r)): return l == r
      case (.setMapObject(let l), .setMapObject(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct FlutterHereMaps_MapChannelReplay {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var object: OneOf_Object? {
    get {return _storage._object}
    set {_uniqueStorage()._object = newValue}
  }

  ///Map actions
  var getCenter: FlutterHereMaps_MapCenter {
    get {
      if case .getCenter(let v)? = _storage._object {return v}
      return FlutterHereMaps_MapCenter()
    }
    set {_uniqueStorage()._object = .getCenter(newValue)}
  }

  var mapGesture: FlutterHereMaps_MapGesture {
    get {
      if case .mapGesture(let v)? = _storage._object {return v}
      return FlutterHereMaps_MapGesture()
    }
    set {_uniqueStorage()._object = .mapGesture(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Object: Equatable {
    ///Map actions
    case getCenter(FlutterHereMaps_MapCenter)
    case mapGesture(FlutterHereMaps_MapGesture)

  #if !swift(>=4.1)
    static func ==(lhs: FlutterHereMaps_MapChannelReplay.OneOf_Object, rhs: FlutterHereMaps_MapChannelReplay.OneOf_Object) -> Bool {
      switch (lhs, rhs) {
      case (.getCenter(let l), .getCenter(let r)): return l == r
      case (.mapGesture(let l), .mapGesture(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "FlutterHereMaps"

extension FlutterHereMaps_MapChannelRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MapChannelRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "setCenter"),
    2: .same(proto: "setConfiguration"),
    3: .same(proto: "zoomTo"),
    20: .same(proto: "setMapObject"),
  ]

  fileprivate class _StorageClass {
    var _object: FlutterHereMaps_MapChannelRequest.OneOf_Object?

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _object = source._object
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1:
          var v: FlutterHereMaps_MapCenter?
          if let current = _storage._object {
            try decoder.handleConflictingOneOf()
            if case .setCenter(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._object = .setCenter(v)}
        case 2:
          var v: FlutterHereMaps_Configuration?
          if let current = _storage._object {
            try decoder.handleConflictingOneOf()
            if case .setConfiguration(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._object = .setConfiguration(v)}
        case 3:
          var v: FlutterHereMaps_ZoomTo?
          if let current = _storage._object {
            try decoder.handleConflictingOneOf()
            if case .zoomTo(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._object = .zoomTo(v)}
        case 20:
          var v: FlutterHereMaps_MapObject?
          if let current = _storage._object {
            try decoder.handleConflictingOneOf()
            if case .setMapObject(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._object = .setMapObject(v)}
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      switch _storage._object {
      case .setCenter(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      case .setConfiguration(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      case .zoomTo(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      case .setMapObject(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 20)
      case nil: break
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FlutterHereMaps_MapChannelRequest, rhs: FlutterHereMaps_MapChannelRequest) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._object != rhs_storage._object {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension FlutterHereMaps_MapChannelReplay: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MapChannelReplay"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "getCenter"),
    2: .same(proto: "mapGesture"),
  ]

  fileprivate class _StorageClass {
    var _object: FlutterHereMaps_MapChannelReplay.OneOf_Object?

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _object = source._object
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1:
          var v: FlutterHereMaps_MapCenter?
          if let current = _storage._object {
            try decoder.handleConflictingOneOf()
            if case .getCenter(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._object = .getCenter(v)}
        case 2:
          var v: FlutterHereMaps_MapGesture?
          if let current = _storage._object {
            try decoder.handleConflictingOneOf()
            if case .mapGesture(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._object = .mapGesture(v)}
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      switch _storage._object {
      case .getCenter(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      case .mapGesture(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      case nil: break
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FlutterHereMaps_MapChannelReplay, rhs: FlutterHereMaps_MapChannelReplay) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._object != rhs_storage._object {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
