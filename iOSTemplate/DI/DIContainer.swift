//
//  DIContainer.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 19/10/21.
//

import Foundation
import Swinject

/// Wrap of Swinject
public class DIContainer {

    public static let `default` = DIContainer()

    private let container = Container()

    @discardableResult
    public func register<Service>(_ serviceType: Service.Type,
                                  name: String? = nil,
                                  factory: @escaping (Resolver) -> Service)
        -> DIServiceEntry
    {
        return container.register(serviceType,
                                   name: name,
                                   factory: factory)
    }

    public func resolve<Service>(type: Service.Type) -> Service? {
        return container.synchronize().resolve(type, name: nil)
    }

    public func resolve<Service>(type: Service.Type, named: String) -> Service? {
        return container.synchronize().resolve(type, name: named)
    }

}

public enum DIScope {

    case transient
    case graph
    case container
    case weak

}

public protocol DIServiceEntry {

    func inScope(_ scope: DIScope)

}

extension ServiceEntry: DIServiceEntry {

    public func inScope(_ scope: DIScope) {
        var objectScope: ObjectScope
        switch scope {
        case .transient:
            objectScope = .transient
        case .graph:
            objectScope = .graph
        case .container:
            objectScope = .container
        case .weak:
            objectScope = .weak
        }

        inObjectScope(objectScope)
    }

}

public protocol DependencyRegistrarProtocol {

    static func registerInstance(in container: DIContainer)

}
