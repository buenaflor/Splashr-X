//
//  HTTPStatusCode.swift
//  Splashr-X
//
//  Created by Gino on 22.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public enum HTTPStatusCodes: Int {
  
  /// In we can't init the status code, shouldn't happen though
  case Unknown
  
  // 100 Informational
  case Continue = 100
  case SwitchingProtocols
  case Processing
  // 200 Success
  case OK = 200
  case Created
  case Accepted
  case NonAuthoritativeInformation
  case NoContent
  case ResetContent
  case PartialContent
  case MultiStatus
  case AlreadyReported
  case IMUsed = 226
  // 300 Redirection
  case MultipleChoices = 300
  case MovedPermanently
  case Found
  case SeeOther
  case NotModified
  case UseProxy
  case SwitchProxy
  case TemporaryRedirect
  case PermanentRedirect
  // 400 Client Error
  case BadRequest = 400
  case Unauthorized
  case PaymentRequired
  case Forbidden
  case NotFound
  case MethodNotAllowed
  case NotAcceptable
  case ProxyAuthenticationRequired
  case RequestTimeout
  case Conflict
  case Gone
  case LengthRequired
  case PreconditionFailed
  case PayloadTooLarge
  case URITooLong
  case UnsupportedMediaType
  case RangeNotSatisfiable
  case ExpectationFailed
  case ImATeapot
  case MisdirectedRequest = 421
  case UnprocessableEntity
  case Locked
  case FailedDependency
  case UpgradeRequired = 426
  case PreconditionRequired = 428
  case TooManyRequests
  case RequestHeaderFieldsTooLarge = 431
  case UnavailableForLegalReasons = 451
  // 500 Server Error
  case InternalServerError = 500
  case NotImplemented
  case BadGateway
  case ServiceUnavailable
  case GatewayTimeout
  case HTTPVersionNotSupported
  case VariantAlsoNegotiates
  case InsufficientStorage
  case LoopDetected
  case NotExtended = 510
  case NetworkAuthenticationRequired
}

public extension HTTPStatusCodes {
  var errorDescription: String {
    return "HTTP Error: \(String(describing: self)). Status Code: \(self.rawValue) "
  }
}

extension Error {
  var httpErrorDescription: String? {
    if let self = self as? HTTPStatusCodes {
      return self.errorDescription
    }
    return nil
  }
}
