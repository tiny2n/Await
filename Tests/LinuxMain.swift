import XCTest

import AwaitTests

var tests = [XCTestCaseEntry]()
tests += AwaitTests.allTests()
XCTMain(tests)
